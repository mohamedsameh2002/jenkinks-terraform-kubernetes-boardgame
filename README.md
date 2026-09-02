# Cloud-Native CI/CD Pipeline & AWS Infrastructure

<p align="center">
  <img src="jenkinks-terraform-kubernetes-boardgame\terraform\docs\diagrams\546541.jpeg" alt="CI/CD & Infrastructure Architecture Diagram" width="100%">
</p>

---

## 📌 Project Overview

This project showcases an end-to-end **DevOps & Cloud Engineering** solution. It combines a robust **CI/CD Pipeline** with a highly available, secure, and scalable **AWS Cloud Infrastructure** designed for containerized applications.

The goal is to automate code testing, security scanning, artifact management, and application deployment to an **Amazon EKS (Kubernetes) Cluster**, supported by continuous observability and automated deployment triggering.

---

## 🛠️ Tech Stack & Key Features

The architecture is divided into three core functional components:

### 1. CI/CD Pipeline Automation
Orchestrated by **Jenkins**, the pipeline handles code integration and delivery end-to-end through the following stages:

* **Source Control (GitHub):** Manages application source code and triggers pipeline execution upon code changes.
* **Continuous Integration (Jenkins):** Automation server orchestrating build, security, and deployment pipelines.
* **Build & Unit Testing (Maven):** Compiles application source code and runs unit tests.
* **Code Quality Assurance (SonarQube):** Analyzes source code for bugs, vulnerabilities, and code smells.
* **Vulnerability Scanning (Aqua Trivy):** Conducts security scanning on both source dependencies and final Docker container images.
* **Package Management (Nexus):** Stores built software artifacts (JAR/WAR packages) for release tracking.
* **Containerization (Docker):** Packages the application into lightweight, reproducible container images.
* **Container Registry (AWS ECR):** Stores production-ready Docker images securely on AWS.
* **Automated CD Triggering:** Jenkins captures successful image pushes to AWS ECR and automatically updates Kubernetes manifests to deploy the new application version onto the EKS cluster.

### 2. AWS Cloud Infrastructure (Medium-Scale)
Designed within an isolated Virtual Private Cloud (**VPC**) ensuring high availability and multi-AZ resilience:

* **Networking & Security:**
  * **Public Subnets:** Hosts **Application Load Balancers (ALB)** for public traffic and **NAT Gateways** for outbound internet connectivity from private subnets.
  * **Private Subnets:** Houses critical workload instances, database clusters, and cache nodes isolated from direct internet access.
* **Container Orchestration (Amazon EKS Cluster):**
  * **Worker Node Groups:** Distributed across multiple availability zones for High Availability (HA).
  * **Deployed Workloads:** Hosts application pods running the live website.
* **Data & Caching Layer:**
  * **Amazon RDS (PostgreSQL):** Fully managed, resilient relational database running in private subnets.
  * **ElastiCache (Redis):** High-performance in-memory caching layer optimizing application response times.

### 3. Monitoring, Auditing & Alerting
* **Observability (Prometheus & Grafana):** Collects cluster metrics, workload health, and performance data, displaying them via real-time Grafana dashboards.
* **Security Auditing (KubeAudit):** Scans Kubernetes resources against security best practices and misconfigurations.
* **Notifications (Mail / Gmail):** Sends automated email alerts regarding pipeline execution status and deployment events.

---

## 🚀 Deployment Workflow

1. **Code Push:** Developer pushes updated code to **GitHub**.
2. **Pipeline Trigger:** **Jenkins** detects the change and executes the pipeline workflow.
3. **Quality & Security Gates:** Code is tested, audited (**SonarQube**), and scanned (**Aqua Trivy**).
4. **Artifact & Image Storage:** Build packages are saved to **Nexus**, and Docker images are pushed to **AWS ECR**.
5. **Continuous Deployment:** **Jenkins** triggers a deployment update to the **Amazon EKS Cluster**.
6. **Live Serving:** **Amazon EKS** updates application pods running in private subnets, served publicly via the **Application Load Balancer (ALB)**.
7. **Continuous Observability:** **Prometheus & Grafana** monitor cluster health, while **KubeAudit** maintains cluster security compliance.