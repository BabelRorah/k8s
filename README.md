FastAPI Test App — Helm & Kubernetes

This project is a simple FastAPI application designed for deployment in a Kubernetes cluster using Helm. It includes:

- A single `/test` endpoint
- API key header authentication (`X-Key`)
- Dockerized with a non-root user
- Configurable response and API key via environment variables
- Deployable via a Helm chart with dynamic secret generation

---------------------

Requirements

- [Python 3.11](https://www.python.org/)
- [Docker](https://www.docker.com/)
- [Helm](https://helm.sh/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- A running Kubernetes cluster (e.g., Minikube)

---------------------

Clone this repository

```bash
git clone https://github.com/BabelRorah/k8s
cd k8s_eval

---------------------
Run Minikube(or your preferred k8s distribution)
minikube start
kubectl get pods
(if this works then minikube is working properly)

---------------------
Install the helm
helm install fastapi ./helm-chart

---------------------
Port-forward the service 
kubectl port-forward svc/fastapi-app-fastapi 8000:8000

---------------------
Retrieve the API key
kubectl get secret fastapi-app-fastapi -o yaml

copy the api key and run this in powershell
[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("replace this with the api key you got to decode"))
you should get something like this 8FedndALMzO72nrLlHP9AZLxDfqTPlMT
that will be your decoded api key you will use to test the endpoint

---------------------
Test the endpoint

for powershell
Invoke-RestMethod -Uri 'http://localhost:8000/test' -Headers @{ 'X-Key' = '8FedndALMzO72nrLlHP9AZLxDfqTPlMT' }

for wsl
curl -H "X-Key: <your-api-key>" http://localhost:8000/test
(Replace your <your-api-key> with the actual api key)\

both responses should be
{
  "response": "it works!"
}

----------------------
Uninstall
helm uninstall fastapi