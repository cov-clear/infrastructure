# COV-Clear infrastructure

This repository holds all the configuration needed to run cov-clear in AWS.


## Description

There are two main things happening in this repository

#### terraform

This are two folders with terraform files:

- **modules**: All the modules that implement the resources needed for cov-clear. At the moment, this is mainly a secure
  VPC, a PostgreSQL RDS database and an EKS cluster (managed by fargate).
- **environments**: There is one folder for each environment where cov-clear is installed. There is only one at the moment
  as we are running all the environments in the same EKS cluster, but different namespaces. All the terraform commands
  (plan, apply, ...), must be run from inside one of the envs.

#### manifests

Once the Kubernetes cluster is created, a set of very basic manifests must be run to configure few security profiles and
to configure the ALB, between others.

There is a convenient `apply.sh` script (inside of the manifests folder) you can run to apply all the manifests. Make
sure your kubectl is pointing to the right context before running it


## Useful recipes

### Get access to the k8s cluster

First you need to install a set of dependencies:

```
$ pip install awscli
$ brew install kubernetes-cli
```

Now you need to [add yourself](https://github.com/cov-clear/terraform/pull/1) to the list of developers. Once that's
applied, login to the AWS console, go to IAM, users, your user, reset your password, add a 2FA device, and generate
a pair of access/secret keys.

You can now configure your AWS cli:

```sh
$ aws configure
```

Once you have access to AWS, you can configure your kubectl to access the EKS cluster. 

```
$ aws eks --region eu-west-1 update-kubeconfig --name cov-clear
```

This should give you access to start using the cluster:

```
$ kubectl get all
```

### Check the backend/web logs

You need first [#get-access-to-the-k8s-cluster](access to the kubernetes cluster.) Once you have it, you only need to
list the pods in the environment you are interested in. For example, for the UK deployment:

```sh
$ kubectl -n uk get pods
```

Now, pick one of the pods, and open its logs:

```sh
$ kubectl -n uk logs uk-123123-123123
```
