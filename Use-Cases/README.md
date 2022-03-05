
### Test

- [ ] Deploy HAProxy Ingress Controller
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

#### Preparations

> Install Kubectl

```bash
curl -LO https://dl.k8s.io/release/v1.19.0/bin/linux/amd64/kubectl
chmod +x kubectl
mv kubectl /usr/local/bin/
```


> Install Helm

```bash
wget -O helm.tar.gz https://get.helm.sh/helm-v3.6.0-linux-amd64.tar.gz

tar -zxvf helm.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm

rm linux-amd64 -rf
rm helm.tar.gz -rf
# Validate
helm
```


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








