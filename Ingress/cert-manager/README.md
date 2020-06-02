# Readme

```shell
kubectl create namespace cert-manager

helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v0.15.1 \
  --set installCRDs=true
```
