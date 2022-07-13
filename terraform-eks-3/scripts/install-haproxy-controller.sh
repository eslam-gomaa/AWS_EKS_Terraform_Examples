
helm repo add haproxytech \
  https://haproxytech.github.io/helm-charts

# see available repositories
helm repo list

# refresh your list of charts
helm repo update

# Install with Helm
helm upgrade --install haproxy-ingress \
  haproxytech/kubernetes-ingress \
  -n haproxy-controller \
  --create-namespace \
  --set controller.ingressClass=haproxy \
  --values scripts/haproxy-values-v1.yaml


kubectl get all -n haproxy-controller

# Check the HAProxy Service & get the DNS name of the LB
kubectl get svc -n haproxy-controller

# Check the status of the load balancer
aws elbv2 describe-load-balancers --region us-east-1