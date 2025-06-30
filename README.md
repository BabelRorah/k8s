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
kubectl port-forward svc/fastapi-fastapi 8000:8000

---------------------
Retrieve the API key
kubectl get secret fastapi-fastapi -o jsonpath="{.data.api_key}" | base64 -d

---------------------
Test the endpoint
curl -H "X-Key: <your-api-key>" http://localhost:8000/test
(Replace your <your-api-key> with the actual api key)
you should get
{
  "response": "it works!"
}

----------------------
Uninstall
helm uninstall fastapi