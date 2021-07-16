kubectl create ns traefik-v2
# Install in the namespace "traefik-v2"
helm install --namespace=traefik-v2 \
    traefik traefik/traefik