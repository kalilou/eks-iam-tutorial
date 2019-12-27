# eks-iam-tutorial

Allowing application in the pod to have an associated IAM role was the most demanding feature and AWS finally made it available this year. So basically, EKS natively support IAM permission to Kubernetes Service Accounts.

## Using eksclt

More detailed documentation on https://blog.revolight.io/

```bash
$ eksctl create cluster eks-iam

$ eksctl utils associate-iam-oidc-provider --name eks-iam --approve

$ aws eks list-clusters  --region REDACTED

$ aws eks describe-cluster --name eks-iam --query cluster.identity.oidc.issuer --region REDACTED

$ eksctl create iamserviceaccount --name eks-iam-test --namespace default --cluster eks-iam --attach-policy-arn arn:aws:iam::aws:policy/ReadOnlyAccess --approve --override-existing-serviceaccounts

$ kubectl get sa -n default

$ kubectl describe sa eks-iam-test -n default

$ kubectl apply -f eks_iam_example.yaml -n default

$ kubectl exec -it <pod_name> -n default aws s3 ls
```

## Using terraform
More detailed documentation on https://blog.revolight.io/

## Using CloudFormation
More detailed documentation on https://blog.revolight.io/
