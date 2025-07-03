# FastAPI Test App — Helm & Kubernetes

This project is a simple FastAPI application designed for deployment in a Kubernetes cluster using Helm. It includes:

- A single `/test` endpoint
- API key header authentication (`X-Key`)
- Dockerized with a non-root user
- Configurable response and API key via environment variables
- Deployable via a Helm chart with dynamic secret generation

---

### Requirements

- [Python 3.11](https://www.python.org/)
- [Docker](https://www.docker.com/)
- [Helm](https://helm.sh/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- A running Kubernetes cluster (e.g., Minikube)

---

### Clone this repository

```powershell
git clone https://github.com/BabelRorah/k8s
cd k8s
```
### Run Minikube(or your preferred k8s distribution)

```powershell
minikube start
kubectl get pods
```
(if this works then minikube is working properly)

---
### Install the Helm

```powershell
helm install fastapi ./helm-chart
```

---
### Port-forward the service

```powershell
kubectl port-forward svc/fastapi-app-fastapi 8000:8000
```
tip: you will need to keep that terminal open(port forwarding takes control), just open up an additional one to move forward

---
### Retrieve the API key

```powershell
kubectl get secret fastapi-app-fastapi -o yaml
```
copy the api key and run this in powershell
```powershell
[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("replace this with the api key you got to decode"))
```
you should get the decoded version of the api-key used to test the endpoint

For WSL
```bash
echo "<put-your-api-key>" | base64 -d
```
---
### Test the endpoint

For Powershell
```powershell
Invoke-RestMethod -Uri 'http://localhost:8000/test' -Headers @{ 'X-Key' = '<your-api-key>' }
```

For WSL
```bash
curl -H "X-Key: <your-api-key>" http://localhost:8000/test
```

you should get
```powershell
{
  "response": "it works!"
}
```
----
### Uninstall
```powershell
helm uninstall fastapi
```