# nginx-helm-ansible-operator

Initalize the operator:
```bash
operator-sdk init \
  --domain shubhamtatvamasi.com \
  --plugins ansible
```

Create an API:
```bash
operator-sdk create api \
  --group server \
  --version v1 \
  --kind Nginx \
  --generate-role \
  --generate-playbook
```

Set the operator image name:
```bash
export IMG=shubhamtatvamasi/nginx-helm-ansible-operator:0.0.3
```

Build and push operator docker image:
```bash
make docker-build docker-push IMG=${IMG}
```

Deploy operator:
```bash
make deploy IMG=${IMG}
```

Install Custom Resource Definition:
```bash
make install
```

Install Custom Resource:
```bash
kubectl apply -f config/samples/server_v1_nginx.yaml
```

Delete Custom Resource:
```bash
kubectl delete -f config/samples/server_v1_nginx.yaml
```

---

Manual installation:
```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install nginx bitnami/nginx

# Uninstall
helm un nginx
```

