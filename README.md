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
This orchestrator enables the automated deployment and synchronization of a containerized application across Kubernetes clusters on AWS, GCP, and Azure. By leveraging Argo CD, it implements a GitOps methodology where the Git repository serves as the single source of truth, eliminating vendor lock-in and improving application availability.

🏗️ Architecture
The architecture is centered around a GitOps model where Argo CD continuously monitors a Git repository for the desired state of the application.

Flask App: A simple web application containerized using Docker.

Kubernetes Clusters: Provisioned on AWS (EKS), GCP (GKE), and Azure (AKS) using Terraform. One cluster (e.g., EKS) hosts the Argo CD instance.

Argo CD: Pulls Kubernetes manifests from a Git repo and applies them to all registered clusters.

Git Repository: Contains the application's Kubernetes manifests and serves as the single source of truth.

ApplicationSet: An Argo CD resource used to automate application deployments across multiple clusters.

Docker Hub: Serves as the container image registry.

CI/CD Pipeline: Automates building the Docker image and updating the image tag in the Kubernetes manifests.

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
git clone [https://github.com/your-repo/project.git](https://github.com/your-repo/project.git)
cd project

2. Build and Push Flask App Image
This step is typically handled by the CI pipeline but can be done manually for the initial setup.

cd flask-app
docker build -t amank772004/flask-app:latest .
docker push amank772004/flask-app:latest

3. Provision Kubernetes Clusters
Use the provided Terraform scripts to create your multi-cloud infrastructure.

AWS EKS (Host Cluster):

cd terraform/aws-eks
terraform init && terraform apply

GCP GKE & Azure AKS (Member Clusters):
Follow similar steps in their respective directories. Ensure you have kubectl contexts configured for all three clusters post-provisioning.

🚀 GitOps Deployment with Argo CD
1. Install Argo CD on the Host Cluster (EKS)
# Create the namespace for Argo CD
kubectl --context=<eks-context> create namespace argocd

# Apply the Argo CD installation manifests
kubectl --context=<eks-context> apply -n argocd -f [https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml](https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml)

2. Access the Argo CD UI
Expose the Argo CD server via port-forwarding for access.

kubectl port-forward svc/argocd-server -n argocd 8080:443

Access the UI at https://localhost:8080. Retrieve the initial admin password with:

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

3. Register Member Clusters with Argo CD
From your local machine, add the GKE and AKS clusters to Argo CD.

# List all kubectl contexts
kubectl config get-contexts

# Add clusters
argocd cluster add <gke-context>
argocd cluster add <aks-context>

4. Apply the ApplicationSet
This instructs Argo CD to deploy the Flask app to all registered clusters.

kubectl --context=<eks-context> apply -f argocd/flask-app-appset.yaml

Argo CD will now create Application resources for each cluster and keep them synchronized with your Git repository.

🔁 CI/CD Automation
The CI pipeline (.github/workflows/ci-pipeline.yml) automates the following on a push to the main branch:

Builds a new Docker image from the Flask app source.

Pushes the tagged image to Docker Hub.

Updates the image tag in kubernetes/deployment.yaml and commits the change back to the repository.

Argo CD detects the manifest change in Git and automatically rolls out the new application version to all clusters, completing the GitOps loop.

🧪 Testing
Verify that the application is running correctly on each cluster.

# Check pods on GCP
kubectl --context=<gke-context> get pods -n flask-app

# Check services on Azure
kubectl --context=<aks-context> get services -n flask-app

# Check pods on AWS
kubectl --context=<eks-context> get pods -n flask-app

Test access using the external IP or LoadBalancer endpoint provided by the service on each cloud.

🙌 Credits
Developed by: Aman K

Guidance: Prof. Neetesh (IIT Roorkee)
