# Sample APP -- Nginx

<br>

* Change the domain name in the [ingress resource](Use-Cases/sample-app-nginx-1/nginx-ingress.yaml)


<br>

```bash
cd Use-Cases/sample-app-nginx-1
kubectl apply -f .
```

```bash
cat nginx-ingress.yaml  | grep host

curl nginx.elb.devops-caffe.com
```

