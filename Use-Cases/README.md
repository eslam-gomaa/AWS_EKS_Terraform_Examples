
## Thinking

- [x] Deploy HAProxy Ingress Controller
- [x] Deploy a sample application (Siyuan)
- [ ] Deploy a sample application (Nginx) 
- [ ] Access the Nginx webserver with Path
- [ ] Create a CNAME for the NLB url from a DNS provider (NameCheap)
- [ ] Access the Nginx webserver with domain

#### More to be done.
- [ ] Deploy Prometheus, Grafana, AlertManager & access them via the Ingress controller
- [ ] Monitor the EKS cluster with Prometheus
- [ ] Monitor the EKS cluster with CloudWatch ! 🤔
- [ ] Monitor the HAProxy Ingress Controller with Prometheus
- [ ] Monitor the Nginx webserver with Prometheus 
- [ ] Deploy ELK Stack


<br>


---


#### Deploy HAProxy Ingress Controller

```bash
helm repo add haproxytech https://haproxytech.github.io/helm-charts
helm repo update
```

```bash
helm install haproxy-ingress \
  haproxytech/kubernetes-ingress \
  -n haproxy-controller \
  --create-namespace \
  --set controller.ingressClass=haproxy \
  --values haproxy-values.yaml
```

##### Validate

```bash
kubectl get all -n haproxy-controller
```








