# Todo-EKS
Todo  EKS Cluster Terraform Code 

## Create AWS EKS Cluster 
Run:
> -     terraform init  : To download needed resources according to your cloud provider ex aws,azure,...
> -     terraform plan  : To make sure what resources will be created.
> -     terraform apply : To apply resources.

## Create Kubeconfig file:
Run: 
> -     aws eks --region ReginValue update-kubeconfig --name ClusterName --profile AWSCredentialProfile 

Note: it will update default config file in .kube path in Home directory so don't forget to backup this file before running this command 

## Deploy Cluster Autoscaler: 

All the steps according to this link ==> [Cluster Autoscaler](https://docs.aws.amazon.com/eks/latest/userguide/cluster-autoscaler.html)

1. Deploy the Cluster Autoscaler.
> -     kubectl apply -f https://raw.githubusercontent.com/kubernetes/autoscaler/master/cluster-autoscaler/cloudprovider/aws/examples/cluster-autoscaler-autodiscover.yaml

2. Annotate the cluster-autoscaler service account with the ARN of the IAM role.
> -     kubectl annotate serviceaccount cluster-autoscaler -n kube-system  eks.amazonaws.com/role-arn=arn:aws:iam::<AccountID>:role/Todo-eks-role

3. Patch the deployment to add the cluster-autoscaler.kubernetes.io/safe-to-evict annotation to the Cluster Autoscaler pods with the following command.
> -     kubectl patch deployment cluster-autoscaler -n kube-system -p '{"spec":{"template":{"metadata":{"annotations":{"cluster-autoscaler.kubernetes.io/safe-to-evict": "false"}}}}}' 

4. Edit the cluster-autoscaler container command to replace <YOUR CLUSTER NAME> with the name of your cluster in our case "Todo-eks"
> -     kubectl -n kube-system edit deployment.apps/cluster-autoscaler

 and add the following options:
> -     - --balance-similar-node-groups
> -     - --skip-nodes-with-system-pods=false

5. Set Cluster Autoscaler version that matches the Kubernetes major and minor version of your cluster. For example, if the Kubernetes version of your cluster is 1.21, find the latest Cluster Autoscaler release that begins with 1.21 so in our case.

> -     kubectl set image deployment cluster-autoscaler -n kube-system cluster-autoscaler=k8s.gcr.io/autoscaling/cluster-autoscaler:v1.20.0 


## Deploy AWS Load Balancer Controller:

All the steps according to this link ==> [AWS Load Balancer Controller](https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html)

1. Create ALB ServiceAccount but first replace <AccountID> with your account ID.
> -     kubectl apply -f ALB-Ingress-Controller-K8s-yaml/ALB-ServiceAccount.yaml

2. Install cert-manager to inject certificate configuration into the webhooks.
> -     kubectl apply  —validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.1.1/cert-manager.yaml 

3. Apply the controller specification.
> -     kubectl apply -f ALB-Ingress-Controller-K8s-yaml/ALB-Deploy.yaml


