Understand → Use → Build → Break → Rebuild → Production → Troubleshoot → Deep Dive → Teach → Design



----------------------------------------------------------------------------

لو قصدك AWS Infrastructure، فلو فهمت وصممت الحاجات دي كويس، هتغطي تقريبًا 80–90% من البنية التحتية الشائعة اللي هتقابلها في شغل DevOps/Cloud:

1. Networking — الأساس
VPC
Availability Zones
Public / Private Subnets
Route Tables
Internet Gateway
NAT Gateway
Security Groups
NACLs
VPC Endpoints
DNS / Route 53
2. Compute
EC2
Auto Scaling Group
Load Balancer (ALB/NLB)
EKS / Kubernetes
ECR
Lambda بدرجة أقل حسب طبيعة الشركة
3. Databases & Storage
RDS
DynamoDB
S3
ElastiCache / Redis
EBS / EFS عند الحاجة
4. Security & IAM
IAM Users/Roles/Policies
IAM Role for EC2/EKS
Secrets Manager
KMS
ACM / TLS Certificates
Security Groups
5. Containers & Kubernetes

لو شغلك DevOps:

EKS
Nodes / Node Groups
Deployments
Services
Ingress
ALB Controller
ConfigMaps / Secrets
HPA
Helm
Karpenter
6. CI/CD

السيناريو الأكثر شيوعًا:

Developer
   ↓
GitHub
   ↓
CI Pipeline
   ↓
Build + Test + Security Scan
   ↓
Docker Image
   ↓
ECR
   ↓
CD / GitOps
   ↓
EKS

وأدوات مثل:

Jenkins / GitHub Actions / GitLab CI
Argo CD
Docker
Helm
7. Infrastructure as Code

Terraform تحديدًا:

Terraform
   ↓
VPC
EKS
IAM
RDS
S3
ALB
Route53
Secrets
Monitoring

ومهم جدًا تعرف:

Modules
Variables
Outputs
Remote Backend
State
Workspaces / environments
8. Observability
Prometheus
Grafana
CloudWatch
Logs
Metrics
Alerts
Distributed tracing بدرجة أقل
لو عايز تحفظها كـ Blueprint واحدة

غالبًا التصميم هيبقى قريب من:

                    Internet
                       │
                  Route 53
                       │
                  ┌────▼────┐
                  │   ALB   │
                  └────┬────┘
                       │
              ┌────────▼────────┐
              │       VPC        │
              │                  │
        ┌─────▼─────┐    ┌──────▼──────┐
        │ Public AZ │    │ Public AZ   │
        │            │    │             │
        │ ALB/NAT    │    │ ALB/NAT     │
        └─────┬──────┘    └──────┬──────┘
              │                   │
        ┌─────▼──────┐      ┌─────▼──────┐
        │Private AZ  │      │Private AZ  │
        │            │      │             │
        │ EKS Nodes  │      │ EKS Nodes   │
        └─────┬──────┘      └─────┬──────┘
              │                   │
              └────────┬──────────┘
                       │
          ┌────────────▼────────────┐
          │ RDS / Redis / DynamoDB  │
          └─────────────────────────┘

       S3 ─── ECR ─── IAM ─── Secrets Manager
                         │
                  CI/CD + Argo CD
                         │
                Prometheus/Grafana

ولو هدفك DevOps تحديدًا: ركّز بالترتيب على Networking → IAM → EC2 → ALB → S3/RDS → Docker → EKS → Terraform → CI/CD → Monitoring. دول أهم 90% فعلًا، والباقي توسعات حسب الشركة والـarchitecture.

9. Linux

حلها باب باب , و طبقها ف مثال صغير زي المشروع دا





aws s3 rm s3://tfstate-dev-us-east-1-yz37nm --recursive