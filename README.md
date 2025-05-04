# 🌐 Multi-Cloud Deployment Orchestrator with Kubernetes Federation

This project demonstrates a complete end-to-end setup to deploy a Dockerized Flask application across **AWS**, **GCP**, and **Azure** using **Kubernetes Federation (Kubefed)**, **Terraform**, and **CI/CD automation**.

---

## 📌 Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Technologies Used](#technologies-used)
- [Project Structure](#project-structure)
- [Setup Instructions](#setup-instructions)
- [CI/CD Automation](#cicd-automation)
- [Federation Deployment](#federation-deployment)
- [Testing](#testing)
- [Future Work](#future-work)
- [Credits](#credits)

---

## ✅ Overview

This orchestrator allows deployment and synchronization of a containerized application (Flask app) across multiple Kubernetes clusters hosted on **AWS**, **GCP**, and **Azure**, eliminating vendor lock-in and improving availability.

---

## 🏗️ Architecture

- **Flask App** containerized using Docker
- **Kubernetes Clusters** on AWS (EKS), GCP (GKE), Azure (AKS)
- **Terraform** for Infrastructure as Code
- **KubeFed** for federating clusters
- **Federated YAMLs** for multi-cluster resource deployment
- **Docker Hub** as image registry
- Optional **CI/CD pipeline** for automation

---

## 🧰 Technologies Used

- Flask (Python)
- Docker
- Kubernetes (EKS, GKE, AKS)
- Terraform
- Kubefed
- GitHub Actions (optional)
- Docker Hub

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
│   ├── aws-eks/
│   ├── gcp-gke/
│   └── azure-aks/
│
├── kubefed/
│   ├── FederatedNamespace.yaml
│   ├── FederatedDeployment.yaml
│   └── FederatedService.yaml
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
docker build -t amank772004/flask-app:latest .
docker push amank772004/flask-app:latest
```

### 3. Provision Clusters

- **AWS:**  
  `cd terraform/aws-eks && terraform init && terraform apply -var-file="terraform.tfvars"`

- **GCP & Azure:**  
  Use provided Terraform files or create clusters via cloud console.

---

## 🚀 Federation Deployment

### 1. Setup `kubefed` on AWS (host cluster)

```bash
kubefed init
kubefedctl join <cluster> --host-cluster-context=<eks-context>
```

### 2. Apply Federated Resources

```bash
kubectl apply -f kubefed/FederatedNamespace.yaml
kubectl apply -f kubefed/FederatedDeployment.yaml
kubectl apply -f kubefed/FederatedService.yaml
```

---

## 🧪 Testing

```bash
kubectl --context=<cluster> get pods
kubectl --context=<cluster> get services
```

Test access using external service IP or LoadBalancer endpoint.

---

## 🔁 CI/CD Automation

- Use `.github/workflows/deploy.yml` to automate:
  - Docker builds
  - Pushing images
  - Re-deploying federated resources

---

## 🙌 Credits

- Developed by Aman K
- Guidance from Prof. Neetesh (IIT Roorkee)
