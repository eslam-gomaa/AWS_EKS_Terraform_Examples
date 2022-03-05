
# Deploy the HAProxy Ingress Controller with Helm

The Helm configuration are in [haproxy-values.yaml](haproxy-values.yaml),  Take a look at them

*Description, TBD*


```bash
# Install with Helm
helm upgrade --install haproxy-ingress \
  haproxytech/kubernetes-ingress \
  -n haproxy-controller \
  --create-namespace \
  --set controller.ingressClass=haproxy \
  --values haproxy-values.yaml
```

```bash
kubectl get all -n haproxy-controller

# Check the HAProxy Service & get the DNS name of the LB
kubectl get svc -n haproxy-controller

# Check the status of the load balancer
aws elbv2 describe-load-balancers --region us-east-1
```


> Clean up

```bash
helm uninstall haproxy-ingress -n haproxy-cntroller
```
