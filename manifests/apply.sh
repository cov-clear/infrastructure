#!/bin/bash

if [ "$#" -ne 5 ]; then
  echo "Usage: $0 vpc_id vpc_region cluster_name alb_arn envs" >&2
  echo "Ex: $0 vpc-04fasdij1d913d eu-west-1 cov-clear-prod arn:aws:iam::1234556677889:role/cov-clear-prod-eks-alb uk,ee" >&2
  exit 1
fi

VPC_ID=$1
VPC_REGION=$2
CLUSTER_NAME=$3
ALB_ARN=$4
ENVS=$5

# Delete super permissive PodSecurityPolicy
kubectl delete psp/eks.privileged
kubectl delete clusterrole/eks:podsecuritypolicy:privileged
kubectl delete clusterrolebinding/eks:podsecuritypolicy:authenticated

# Add our own security policy
kubectl apply -f security/pod-security-policies.yaml
kubectl apply -f security/manifests-applier.yaml

# Patch coreDNS to run in fargate
kubectl patch -n kube-system deployment/coredns --type json -p='[{"op": "remove", "path": "/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type"}]'

# Install the ALB ingress controller
kubectl create namespace kube-ingress
kubectl apply -f alb-ingress-controller/rbac.yaml
sed "s/\[\[vpc_id\]\]/$VPC_ID/g;s/\[\[vpc_region\]\]/$VPC_REGION/g;s/\[\[cluster_name\]\]/$CLUSTER_NAME/g" alb-ingress-controller/deployment.yaml | kubectl apply -f -
kubectl annotate --overwrite serviceaccount -n kube-ingress default eks.amazonaws.com/role-arn=$ALB_ARN

# Create the environments
for env in $(echo $ENVS | sed "s/,/ /g")
do
    kubectl create namespace $env
    sed "s/\[\[env\]\]/$env/g" security/manifests-applier-binding.yaml | kubectl apply -f -
done
