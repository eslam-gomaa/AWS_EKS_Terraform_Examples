
Install the repo
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

Install
```bash
helm upgrade --install monitoring \
prometheus-community/kube-prometheus-stack \
--values prometheus-values.yaml \
--namespace monitoring \
--create-namespace
```

Validate
```bash
kubectl get all -n monitoring
```

---

Get Grafana default password
```bash
kubectl -n prometheus get secrets kube-prometheus-stack-grafana  -o yaml | grep -i data -C 5
echo "cHJvbS1vcGVyYXRvcg==" | base64 --decode
```

Ingresses
> Make sure that the domains resolves to the LB name

```bash
kubectl apply -f prometheus-ingress.yaml
kubectl apply -f grafana-ingress.yaml
kubectl apply -f alertmanager-ingress.yaml
```
