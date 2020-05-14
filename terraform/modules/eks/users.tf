data "aws_eks_cluster_auth" "main" {
  name = aws_eks_cluster.main.name
}

provider "kubernetes" {
  alias = "eks_main"

  host                   = aws_eks_cluster.main.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.main.token
  load_config_file       = false
}

resource "kubernetes_config_map" "main_auth" {
  provider = kubernetes.eks_main

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode([{
      rolearn = aws_iam_role.fargate.arn
      username : "system:node:{{SessionName}}"
      groups : [
        "system:bootstrappers",
        "system:nodes",
        "system:node-proxier",
      ]
    }])

    mapUsers = yamlencode(
      concat([
        for username in keys(var.developers) : {
          userarn  = var.developers[username].arn
          username = "cov-clear:user:${username}"
          groups   = ["cov-clear:group:developer"]
        }
        ], [
        for username in keys(var.continuous_delivery_bots) : {
          userarn  = var.continuous_delivery_bots[username].arn
          username = "cov-clear:bot:${username}"
          groups   = ["cov-clear:group:continuous-delivery-bots"]
        }
        ], [
        for username in keys(var.admins) : {
          userarn  = var.admins[username].arn
          username = "cov-clear:user:${username}"
          groups   = ["system:masters"]
        }
      ])
    )
  }
}
