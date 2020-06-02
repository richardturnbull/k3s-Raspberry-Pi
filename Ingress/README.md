# Installing MetalLB and Traefik

## 1. Install Metal LB:

```zsh
kubectl apply -f ./metallb/

# On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
```

## 2. Install Traefik:

```zsh
kubectl create ns traefik-v2

# Install in the namespace "traefik-v2"
helm install --namespace=traefik-v2  traefik traefik/traefik
```

To access dashboard: `kubectl port-forward $(kubectl get pods --selector "app.kubernetes.io/name=traefik" --output=name) 9000:9000`

then navigate to [http://localhost:9000/dashboard/](http://localhost:9000/dashboard/)

