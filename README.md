# 🌐 Multi-Cloud Deployment with ArgoCD

This project demonstrates a complete end-to-end setup to deploy a Dockerized Flask application across **AWS**, **GCP**, and **Azure** using **Terraform**, **Kubernetes**, and **ArgoCD**.

---

## 📌 Table of Contents

* [Overview](#overview)
* [Architecture](#architecture)
* [Technologies Used](#technologies-used)
* [Project Structure](#project-structure)
* [Setup Instructions](#setup-instructions)
* [ArgoCD Deployment](#argocd-deployment)
* [Testing](#testing)
* [Future Work](#future-work)
* [Credits](#credits)

---

## ✅ Overview

This orchestrator allows deployment and synchronization of a containerized application (Flask app) across multiple Kubernetes clusters hosted on **AWS**, **GCP**, and **Azure**, eliminating vendor lock-in and improving availability.

---

## 🏗️ Architecture

* **Flask App** containerized using Docker
* **Kubernetes Clusters** on AWS (EKS), GCP (GKE), Azure (AKS)
* **Terraform** for Infrastructure as Code
* **ArgoCD** for GitOps-driven deployment
* **Docker Hub** as image registry

---

## 🧰 Technologies Used

* Flask (Python)
* Docker
* Kubernetes (EKS, GKE, AKS)
* Terraform
* ArgoCD
* GitHub Actions (optional)
* Docker Hub

---

## 📁 Project Structure

```
project/
│
├── flask-app/
│   ├── app.py
│   ├── Dockerfile
│   └── requirements.txt
│
├── terraform/
│   ├── aws/
│   ├── gcp/
│   └── azure/
│
├── manifests/
│   ├── deployment.yaml
│   └── service.yaml
│
├── argocd/
│   └── application.yaml
│
├── docs/   # diagrams, screenshots, reports
│
├── .github/workflows/
│   └── deploy.yml (optional CI/CD)
│
└── README.md
```

---

## ⚙️ Setup Instructions

### 1. Clone Repository

```bash
git clone https://github.com/your-repo/project.git
cd project
```

### 2. Build and Push Flask App

```bash
cd flask-app
docker build -t your-dockerhub-username/flask-app:latest .
docker push your-dockerhub-username/flask-app:latest
```

### 3. Provision Clusters with Terraform

* **AWS:**

  ```bash
  cd terraform/aws && terraform init && terraform apply -var-file="terraform.tfvars"
  ```
* **GCP:**

  ```bash
  cd terraform/gcp && terraform init && terraform apply -var-file="terraform.tfvars"
  ```
* **Azure:**

  ```bash
  cd terraform/azure && terraform init && terraform apply -var-file="terraform.tfvars"
  ```

### 4. Configure Kubeconfig

```bash
aws eks update-kubeconfig --name <cluster-name>
gcloud container clusters get-credentials <cluster-name> --region <region>
az aks get-credentials --resource-group <rg> --name <cluster-name>
```

---

## 🚀 ArgoCD Deployment

### 1. Install ArgoCD (on one cluster)

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### 2. Access ArgoCD UI

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Visit: `https://localhost:8080`

### 3. Deploy Application with ArgoCD

```bash
kubectl apply -f argocd/application.yaml -n argocd
```

---

## 🧪 Testing

```bash
kubectl --context=<cluster> get pods
kubectl --context=<cluster> get services
```

Access the application using the **LoadBalancer service IP** from each cluster.

---

## 🔮 Future Work

* Automate CI/CD with GitHub Actions
* Add monitoring (Prometheus + Grafana)
* Use a Service Mesh (Istio/Linkerd) for cross-cluster traffic

---

## 🙌 Credits

* Developed by Aman Kumar
* Guidance from Prof. Neetesh (IIT Roorkee)
* Project under **Cloud Computing Course**
