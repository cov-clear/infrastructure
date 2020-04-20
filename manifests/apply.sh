#!/bin/bash

echo "Please, read the file (and delete this line) before applying..."
exit 0

# Delete super permissive PodSecurityPolicy
kubectl delete psp/eks.privileged
kubectl delete clusterrole/eks:podsecuritypolicy:privilegedkcs
kubectl delete clusterrolebinding/eks:podsecuritypolicy:authenticated

# Add our own security policy
kubectl apply -f security/pod-security-policies.yaml

# Patch coreDNS to run in fargate
kubectl patch -n kube-system deployment/coredns --type json -p='[{"op": "remove", "path": "/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type"}]'

