#!/bin/bash

if [ "$#" -ne 4 ]; then
  echo "Usage: $0 vpc_id vpc_region cluster_name alb_arn" >&2
  echo "Ex: $0 vpc-04fasdij1d913d eu-west-1 cov-clear-prod arn:aws:iam::1234556677889:role/cov-clear-prod-eks-alb" >&2
  exit 1
fi

# Delete super permissive PodSecurityPolicy
kubectl delete psp/eks.privileged
kubectl delete clusterrole/eks:podsecuritypolicy:privilegedkcs
kubectl delete clusterrolebinding/eks:podsecuritypolicy:authenticated

# Add our own security policy
kubectl apply -f security/pod-security-policies.yaml

# Patch coreDNS to run in fargate
kubectl patch -n kube-system deployment/coredns --type json -p='[{"op": "remove", "path": "/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type"}]'

# Install the ALB ingress controller
kubectl apply -f alb-ingress-controller/rbac.yaml
sed "s/\[\[vpc_id\]\]/$1/g;s/\[\[vpc_region\]\]/$2/g;s/\[\[cluster_name\]\]/$3/g" alb-ingress-controller/deployment.yaml | kubectl apply -f -
kubectl annotate --overwrite serviceaccount -n kube-ingress default eks.amazonaws.com/role-arn=$4
