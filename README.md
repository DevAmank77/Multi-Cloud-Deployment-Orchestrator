🌐 Multi-Cloud Deployment Orchestrator with Argo CD

This project demonstrates a complete end-to-end setup to deploy a Dockerized Flask application across AWS, GCP, and Azure using a GitOps workflow powered by Argo CD, with infrastructure provisioned by Terraform.

📌 Table of Contents

Overview

Architecture

Technologies Used

Project Structure

Setup Instructions

GitOps Deployment with Argo CD

CI/CD Automation

Testing

Credits

✅ Overview

This orchestrator enables automated deployment and synchronization of a containerized application across Kubernetes clusters on AWS, GCP, and Azure.

By leveraging Argo CD, it implements a GitOps methodology where the Git repository serves as the single source of truth. This ensures consistency, eliminates vendor lock-in, and improves application availability.

🏗️ Architecture

The architecture is built around a GitOps model where Argo CD continuously monitors the Git repository for the desired application state:

Flask App → Simple web application containerized using Docker

Kubernetes Clusters → EKS (AWS), GKE (GCP), AKS (Azure), provisioned with Terraform

Argo CD → Runs on the host cluster (e.g., AWS EKS) and deploys to all clusters

Git Repository → Stores Kubernetes manifests (source of truth)

ApplicationSet → Automates multi-cluster deployments from a single config

Docker Hub → Container image registry

CI/CD Pipeline → Builds/pushes Docker image and updates manifests

🧰 Technologies Used

Application: Flask, Docker

Cloud & Orchestration: Kubernetes (EKS, GKE, AKS), Argo CD

Infrastructure as Code: Terraform

CI/CD: GitHub Actions

Registry: Docker Hub

📁 Project Structure
project/
│
├── flask-app/                # Dockerized Flask Application
│   ├── app.py
│   ├── Dockerfile
│   └── requirements.txt
│
├── terraform/                # IaC for AWS, GCP, and Azure clusters
│   ├── aws-eks/
│   ├── gcp-gke/
│   └── azure-aks/
│
├── kubernetes/               # Application manifests
│   ├── namespace.yaml
│   ├── deployment.yaml
│   └── service.yaml
│
├── argocd/                   # Argo CD ApplicationSet
│   └── flask-app-appset.yaml
│
├── .github/workflows/        # CI Pipeline
│   └── ci-pipeline.yml
│
└── README.md

⚙️ Setup Instructions
1. Clone Repository
git clone https://github.com/your-repo/project.git
cd project

2. Build and Push Flask App Image

This is usually handled by the CI pipeline, but can be done manually for the first setup:

cd flask-app
docker build -t amank772004/flask-app:latest .
docker push amank772004/flask-app:latest

3. Provision Kubernetes Clusters

Use Terraform scripts to create the infrastructure.

AWS EKS (host cluster):

cd terraform/aws-eks
terraform init
terraform apply


GCP GKE & Azure AKS (member clusters):

Run the respective Terraform scripts in their directories. Ensure kubectl contexts are available for all three clusters.

🚀 GitOps Deployment with Argo CD
1. Install Argo CD on Host Cluster (EKS)
kubectl --context=<eks-context> create namespace argocd
kubectl --context=<eks-context> apply -n argocd \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

2. Access the Argo CD UI
kubectl port-forward svc/argocd-server -n argocd 8080:443


URL: https://localhost:8080

Get initial admin password:

kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d

3. Register Member Clusters
kubectl config get-contexts
argocd cluster add <gke-context>
argocd cluster add <aks-context>

4. Apply the ApplicationSet
kubectl --context=<eks-context> apply -f argocd/flask-app-appset.yaml


Argo CD will create Application resources for each registered cluster and keep them synced with the Git repository.

🔁 CI/CD Automation

The CI pipeline (.github/workflows/ci-pipeline.yml) automates:

Build a Docker image from Flask app source

Push image to Docker Hub with a new tag

Update kubernetes/deployment.yaml with the new tag

Commit changes back to GitHub

➡️ Argo CD detects the updated manifest and automatically rolls out the new version across all clusters (GitOps loop complete).

🧪 Testing

Check deployments in each cloud provider:

# GCP
kubectl --context=<gke-context> get pods -n flask-app

# Azure
kubectl --context=<aks-context> get services -n flask-app

# AWS
kubectl --context=<eks-context> get pods -n flask-app


Access the app using the LoadBalancer/Ingress external IP from each cluster.

🙌 Credits

Developed by: Aman Kumar

Guidance: Prof. Neetesh (IIT Roorkee)
