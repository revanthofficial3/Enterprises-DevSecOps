# Enterprise DevSecOps CI/CD Platform on AWS

![AWS](https://img.shields.io/badge/AWS-Cloud-orange)
![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4)
![Ansible](https://img.shields.io/badge/Ansible-Automation-EE0000)
![Jenkins](https://img.shields.io/badge/Jenkins-CI%2FCD-D24939)
![Maven](https://img.shields.io/badge/Maven-Build-C71A36)
![SonarQube](https://img.shields.io/badge/SonarQube-Code%20Quality-4E9BCD)
![Nexus](https://img.shields.io/badge/Nexus-Artifact%20Repository-1B1C30)
![Docker](https://img.shields.io/badge/Docker-Containerization-2496ED)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Orchestration-326CE5)
![Prometheus](https://img.shields.io/badge/Prometheus-Monitoring-E6522C)
![Grafana](https://img.shields.io/badge/Grafana-Dashboards-F46800)
![Alertmanager](https://img.shields.io/badge/Alertmanager-Alerting-E6522C)

---

## 📌 Project Title

# Enterprise DevSecOps CI/CD Platform on AWS

A complete enterprise-style DevSecOps CI/CD platform implemented on AWS using
Infrastructure as Code, configuration management, continuous integration,
continuous delivery, code quality analysis, artifact management,
containerization, Kubernetes orchestration, monitoring, and email alerting.

The platform integrates:

- AWS
- Terraform
- Ansible
- GitHub
- Jenkins
- Maven
- SonarQube
- SonarQube Quality Gate
- Nexus Repository
- Docker
- DockerHub
- Kubernetes
- Helm
- Prometheus
- Grafana
- Alertmanager
- Email Alerts

---

# 📖 Project Overview

The objective of this project is to implement a complete DevSecOps workflow
for a Java-based web application.

The source code is maintained in GitHub. Jenkins retrieves the source code and
starts the CI/CD pipeline.

The pipeline performs the following operations:

1. Checkout source code from GitHub
2. Build the Java application using Maven
3. Perform SonarQube code analysis
4. Validate the SonarQube Quality Gate
5. Deploy the Maven artifact to Nexus
6. Build a Docker image
7. Authenticate with DockerHub
8. Tag the Docker image using Jenkins BUILD_NUMBER
9. Push the Docker image to DockerHub
10. Update the Kubernetes Deployment
11. Deploy the new application version to Kubernetes Pods
12. Monitor the environment using Prometheus
13. Visualize metrics using Grafana
14. Process alerts using Alertmanager
15. Send email notifications for configured alerts

---

# 🎯 Project Objectives

The major objectives of this project are:

- Implement Infrastructure as Code using Terraform
- Automate server configuration using Ansible
- Build a CI/CD pipeline using Jenkins
- Automate Java application builds using Maven
- Perform static code analysis using SonarQube
- Enforce code quality using Quality Gates
- Store build artifacts in Nexus
- Containerize the application using Docker
- Publish container images to DockerHub
- Deploy the application on Kubernetes
- Use Kubernetes Deployment and Service resources
- Use Helm as Kubernetes package management tooling
- Monitor the infrastructure and application
- Create Grafana dashboards
- Configure Prometheus alerting
- Route alerts through Alertmanager
- Send email notifications
- Demonstrate an enterprise-style DevSecOps workflow

---

# ☁️ AWS Infrastructure

AWS Region:

```text
us-east-1
```

The project uses three EC2 servers.

```text
                         AWS us-east-1
                              |
                         Default VPC
                              |
          +-------------------+-------------------+
          |                                       |
          |                                       |
 DevSecOps Server                         Kubernetes Cluster
          |                                       |
          |                             +---------+---------+
          |                             |                   |
          |                        K8s Master          K8s Worker
          |
          +-- Terraform
          +-- Ansible
          +-- Jenkins
          +-- Maven
          +-- SonarQube
          +-- Nexus
          +-- Docker
          +-- Helm
```

---

# 🖥️ Server 1 - DevSecOps Server

Server name:

```text
devsecops-server
```

This server acts as the main DevSecOps automation server.

Installed/configured components:

```text
Terraform
Ansible
Jenkins
Maven
SonarQube
Nexus
Docker
Helm
AWS CLI
Git
```

Docker runtime:

```text
Docker
```

Main responsibilities:

- Infrastructure management
- Configuration automation
- CI/CD execution
- Maven build
- SonarQube analysis
- Quality Gate validation
- Nexus artifact deployment
- Docker image creation
- DockerHub publishing
- Kubernetes deployment commands

---

# 🖥️ Server 2 - Kubernetes Master

Server name:

```text
k8s-master
```

Responsibilities:

- Kubernetes control plane
- Cluster management
- Kubernetes API
- Scheduling and orchestration
- Monitoring stack
- Prometheus
- Grafana
- Alertmanager

Runtime:

```text
containerd
```

Kubernetes components:

```text
kubeadm
kubelet
kubectl
containerd
```

Monitoring components:

```text
Prometheus
Grafana
Alertmanager
```

---

# 🖥️ Server 3 - Kubernetes Worker

Server name:

```text
k8s-worker
```

Responsibilities:

- Kubernetes workload execution
- Application Pod hosting
- Container execution
- Application deployment

Runtime:

```text
containerd
```

Kubernetes components:

```text
kubelet
kubeadm
containerd
```

Application Pods are scheduled onto the Kubernetes worker according to the
Kubernetes Deployment and cluster scheduling configuration.

---

# 🏗️ High-Level Architecture

```text
                         AWS
                          |
                    Default VPC
                          |
        +-----------------+-----------------+
        |                                   |
        |                                   |
 DevSecOps Server                    Kubernetes Cluster
        |                                   |
        |                         +---------+---------+
        |                         |                   |
        |                    K8s Master          K8s Worker
        |                         |                   |
        |                         |               Application
        |                         |                  Pods
        |                         |
        |                    Monitoring
        |                         |
        |              +----------+----------+
        |              |          |          |
        |         Prometheus   Grafana   Alertmanager
        |                                      |
        |                                      v
        |                                 Email Alerts
        |
        +-- Terraform
        +-- Ansible
        +-- Jenkins
        +-- Maven
        +-- SonarQube
        +-- Nexus
        +-- Docker
        +-- Helm
```

---

# 🔧 Infrastructure as Code - Terraform

Terraform is used to manage the existing AWS infrastructure as Infrastructure
as Code.

The Kubernetes EC2 instances were imported into Terraform state instead of
being recreated.

Managed infrastructure:

```text
k8s-master
k8s-worker
```

Terraform directory:

```text
terraform/
├── main.tf
├── outputs.tf
└── terraform.txt
```

---

## Terraform Configuration

The Terraform provider uses:

```text
AWS
Region: us-east-1
```

Terraform resources:

```text
aws_instance.k8s_master
aws_instance.k8s_worker
```

Terraform outputs include:

```text
k8s_master_instance_id
k8s_master_private_ip
k8s_worker_instance_id
k8s_worker_private_ip
```

---

## Terraform Installation

```bash
sudo apt update

sudo apt install -y gnupg software-properties-common curl

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

sudo apt install -y terraform
```

Verify:

```bash
terraform version
```

---

## Terraform Initialization

```bash
cd ~/enterprise-devsecops/terraform

terraform init
```

---

## Terraform Validation

```bash
terraform validate
```

Expected:

```text
Success! The configuration is valid.
```

Format:

```bash
terraform fmt
```

---

## Terraform State

Check state:

```bash
terraform state list
```

Expected:

```text
aws_instance.k8s_master
aws_instance.k8s_worker
```

---

## Terraform Plan

```bash
terraform plan
```

The completed project reached:

```text
No changes.
Your infrastructure matches the configuration.
```

---

## Terraform Apply

After reviewing the plan:

```bash
terraform apply
```

Expected completed-project result:

```text
Resources: 0 added, 0 changed, 0 destroyed.
```

This confirms that the existing AWS infrastructure was not recreated or
destroyed.

---

## Terraform Outputs

```bash
terraform output
```

Outputs:

```text
k8s_master_instance_id
k8s_master_private_ip
k8s_worker_instance_id
k8s_worker_private_ip
```

---

# ⚙️ Configuration Management - Ansible

Ansible is used to automate common configuration and verify the existing
servers.

Ansible manages:

```text
devsecops-server
k8s-master
k8s-worker
```

Directory:

```text
ansible/
├── ansible.cfg
├── inventory
├── ansible.txt
└── playbooks/
    ├── common.yml
    ├── docker.yml
    └── kubernetes.yml
```

---

# Ansible Installation

```bash
sudo apt update

sudo apt install -y ansible
```

Verify:

```bash
ansible --version
```

Project environment:

```text
Ansible Core 2.16.3
Python 3.12.3
```

---

# Ansible Configuration

File:

```text
ansible/ansible.cfg
```

Configuration:

```ini
[defaults]
inventory = ./inventory
remote_user = ubuntu
host_key_checking = False
interpreter_python = auto_silent
timeout = 30

[privilege_escalation]
become = True
become_method = sudo
become_user = root
become_ask_pass = False
```

---

# Ansible Inventory

File:

```text
ansible/inventory
```

Hosts:

```text
devsecops-server
k8s-master
k8s-worker
```

Groups:

```text
devsecops
kubernetes_master
kubernetes_workers
kubernetes
```

Private IP addresses are used for server-to-server communication.

---

# Ansible Connectivity Test

```bash
ansible all -m ping
```

Expected:

```text
devsecops-server | SUCCESS
k8s-master       | SUCCESS
k8s-worker        | SUCCESS
```

Response:

```text
ping: pong
```

---

# Common Server Configuration

Playbook:

```text
ansible/playbooks/common.yml
```

Packages installed:

```text
curl
wget
git
unzip
vim
net-tools
```

Run:

```bash
ansible-playbook playbooks/common.yml
```

Expected:

```text
failed=0
```

---

# Container Runtime Configuration

The project intentionally preserves the existing container runtime architecture.

```text
devsecops-server
        |
      Docker

k8s-master
        |
    containerd

k8s-worker
        |
    containerd
```

Docker is used by the DevSecOps server for building and publishing application
images.

Kubernetes nodes use containerd as the existing Kubernetes container runtime.

Docker was not installed on the Kubernetes servers because replacing the
existing runtime could disturb the working Kubernetes cluster.

---

# Docker / Container Runtime Verification

Playbook:

```text
ansible/playbooks/docker.yml
```

Run:

```bash
ansible-playbook playbooks/docker.yml
```

Verification includes:

```text
Docker service
Docker version
containerd service
containerd version
```

Expected:

```text
Docker -> active
containerd -> active
```

---

# Kubernetes Verification with Ansible

Playbook:

```text
ansible/playbooks/kubernetes.yml
```

Run:

```bash
ansible-playbook playbooks/kubernetes.yml
```

The playbook verifies:

```text
kubelet
kubeadm
kubectl
Kubernetes cluster nodes
```

Expected:

```text
k8s-master   Ready
k8s-worker   Ready
```

---

# 🔄 CI/CD Pipeline

Jenkins is the central CI/CD automation engine.

The CI/CD workflow is:

```text
GitHub
   |
   v
Jenkins
   |
   v
Checkout
   |
   v
Maven Build
   |
   v
SonarQube Analysis
   |
   v
Quality Gate
   |
   v
Nexus
   |
   v
Docker Build
   |
   v
DockerHub
   |
   v
Kubernetes
   |
   v
Application Pods
```

Jenkins documentation:

```text
jenkins/jenkins.txt
```

Pipeline documentation:

```text
jenkins/pipeline.txt
```

---

# Jenkins Pipeline Stages

The implemented pipeline contains:

```text
1. Checkout
2. Build
3. SonarQube Analysis
4. Quality Gate
5. Deploy to Nexus
6. Docker Build
7. Docker Login
8. Docker Tag
9. Docker Push
10. Deploy to Kubernetes
```

---

# Jenkins Tool Configuration

The Jenkinsfile expects:

```text
JDK Tool Name:
JDK21

Maven Tool Name:
Maven
```

SonarQube server configuration:

```text
SonarQube
```

Jenkins credentials:

```text
nexus-creds
jenkins-devsecops
```

Maven managed configuration:

```text
maven-settings
```

---

# Stage 1 - Checkout

Jenkins checks out the source code from GitHub.

Repository:

```text
https://github.com/revanthofficial3/enterprise-devsecops.git
```

Branch:

```text
main
```

Flow:

```text
GitHub
   |
   v
Jenkins Workspace
```

---

# Stage 2 - Maven Build

Command:

```bash
mvn clean package
```

`clean` removes previous Maven build output.

`package` compiles and packages the Java application.

Application packaging:

```text
WAR
```

Expected output:

```text
target/enterprise-devsecops.war
```

---

# ☕ Maven

Maven is used for Java application build and artifact management.

Main file:

```text
pom.xml
```

Project configuration:

```text
groupId:
com.enterprise

artifactId:
enterprise-devsecops

version:
1.0.0

packaging:
war
```

Java compiler configuration:

```text
source:
17

target:
17
```

Dependencies include:

```text
jakarta.servlet-api
```

Maven plugins include:

```text
maven-compiler-plugin
maven-war-plugin
```

---

# Maven Build Lifecycle

```text
Source Code
    |
    v
Maven
    |
    +-- Clean
    |
    +-- Compile
    |
    +-- Test / Verify
    |
    +-- Package
    |
    v
enterprise-devsecops.war
```

Build:

```bash
mvn clean package
```

Deploy:

```bash
mvn clean deploy
```

---

# 🔍 SonarQube

SonarQube performs static code analysis.

Jenkins integration:

```groovy
withSonarQubeEnv('SonarQube')
```

Project key:

```text
enterprise-devsecops
```

Project name:

```text
Enterprise DevSecOps
```

Analysis command:

```bash
mvn clean verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar \
-Dsonar.projectKey=enterprise-devsecops \
-Dsonar.projectName="Enterprise DevSecOps"
```

SonarQube evaluates:

```text
Bugs
Vulnerabilities
Code Smells
Security Hotspots
Coverage
Duplications
```

Documentation:

```text
sonarqube/sonarqube.txt
```

---

# 🚦 SonarQube Quality Gate

The Quality Gate is the pipeline quality checkpoint.

Pipeline:

```groovy
timeout(time: 5, unit: 'MINUTES') {
    waitForQualityGate abortPipeline: true
}
```

Flow:

```text
SonarQube Analysis
       |
       v
Quality Gate
   /       \
PASS       FAIL
 |           |
 v           v
Continue    Abort
Pipeline    Pipeline
```

This prevents the pipeline from continuing when the configured SonarQube
quality criteria are not satisfied.

---

# 📦 Nexus Repository

Nexus Repository Manager is used to store Maven build artifacts.

Pipeline stage:

```text
Deploy to Nexus
```

Maven command:

```bash
mvn clean deploy -s $MAVEN_SETTINGS
```

Jenkins managed file:

```text
maven-settings
```

Jenkins credential:

```text
nexus-creds
```

Maven distribution management points to the Nexus Maven repository.

Expected artifact:

```text
enterprise-devsecops-1.0.0.war
```

Documentation:

```text
nexus/nexus.txt
```

---

# 🐳 Docker

Docker is used to containerize the Java WAR application.

Directory:

```text
docker/
├── Dockerfile
└── docker.txt
```

The root-level Dockerfile has been removed.

The Dockerfile is located at:

```text
docker/Dockerfile
```

Dockerfile base image:

```dockerfile
FROM tomcat:10.1-jdk21
```

The Dockerfile removes the default Tomcat web applications and copies the
built WAR file into Tomcat:

```text
/usr/local/tomcat/webapps/ROOT.war
```

Application port:

```text
8080
```

---

# Docker Build

Because the Dockerfile is inside the `docker/` directory, Jenkins uses:

```bash
docker build \
-t enterprise-devsecops:${BUILD_NUMBER} \
-f docker/Dockerfile .
```

The build context remains the project root because the Dockerfile needs access
to:

```text
target/enterprise-devsecops.war
```

Example image:

```text
enterprise-devsecops:25
```

---

# 🐳 DockerHub

DockerHub is used as the container image registry.

Repository:

```text
revanth76/enterprise-devsecops
```

Pipeline:

```text
Docker Build
      |
      v
Docker Login
      |
      v
Docker Tag
      |
      v
Docker Push
      |
      v
DockerHub
```

---

# Docker Login

Jenkins credential:

```text
jenkins-devsecops
```

Credentials are injected securely using Jenkins Credentials Manager.

Login command:

```bash
echo $DOCKER_PASS | docker login \
-u $DOCKER_USER \
--password-stdin
```

The password/token is not stored directly inside the pipeline source code.

---

# Docker Tag

Local image:

```text
enterprise-devsecops:${BUILD_NUMBER}
```

DockerHub image:

```text
revanth76/enterprise-devsecops:${BUILD_NUMBER}
```

Example:

```text
enterprise-devsecops:25
```

becomes:

```text
revanth76/enterprise-devsecops:25
```

---

# Docker Push

Command:

```bash
docker push revanth76/enterprise-devsecops:${BUILD_NUMBER}
```

Example:

```text
revanth76/enterprise-devsecops:25
```

The image is then available in DockerHub for Kubernetes to pull.

---

# ☸️ Kubernetes

Kubernetes is used for container orchestration and application deployment.

Cluster:

```text
k8s-master
     |
     v
k8s-worker
```

Directory:

```text
k8s/
├── k8s-master.txt
├── k8s-worker.txt
├── deployment.yaml
└── service.yaml
```

---

# Kubernetes Deployment

Deployment name:

```text
enterprise-devsecops
```

Replicas:

```text
2
```

Container name:

```text
enterprise-devsecops
```

Container port:

```text
8080
```

Initial image:

```text
revanth76/enterprise-devsecops:1.0.0
```

Image pull policy:

```text
Always
```

Resource requests:

```text
CPU: 200m
Memory: 256Mi
```

Resource limits:

```text
CPU: 500m
Memory: 512Mi
```

---

# Kubernetes Service

Service name:

```text
enterprise-devsecops-service
```

Service type:

```text
NodePort
```

Service port:

```text
80
```

Target port:

```text
8080
```

NodePort:

```text
30080
```

Application access:

```text
http://<KUBERNETES-NODE-PUBLIC-IP>:30080
```

---

# Kubernetes Deployment Update

Jenkins updates the existing Deployment using:

```bash
kubectl set image deployment/enterprise-devsecops \
enterprise-devsecops=revanth76/enterprise-devsecops:${BUILD_NUMBER}
```

For example:

```text
Jenkins Build Number:
25

New Docker image:
revanth76/enterprise-devsecops:25
```

Kubernetes updates the Deployment and replaces Pods according to the
Deployment strategy.

---

# Kubernetes Verification

Check nodes:

```bash
kubectl get nodes
```

Check Pods:

```bash
kubectl get pods -o wide
```

Check Deployment:

```bash
kubectl get deployment
```

Check Service:

```bash
kubectl get service
```

Check detailed Deployment:

```bash
kubectl describe deployment enterprise-devsecops
```

Check application Pods:

```bash
kubectl describe pods
```

---

# ⎈ Helm

Helm is used as the Kubernetes package manager.

Helm helps manage Kubernetes applications and releases.

Common commands:

```bash
helm version
helm list
helm repo list
helm repo add <repo-name> <repo-url>
helm search repo <repo-name>
```

Documentation:

```text
helm/helm.txt
```

---

# 📊 Monitoring Architecture

Monitoring components:

```text
Prometheus
Grafana
Alertmanager
```

Architecture:

```text
                    Kubernetes
                         |
                         v
                    Prometheus
                    /        \
                   /          \
                  v            v
              Grafana      Alertmanager
                               |
                               v
                           Email Alerts
```

---

# Prometheus

Prometheus is used to collect and store metrics.

Responsibilities:

- Collect monitoring metrics
- Store time-series data
- Query metrics
- Evaluate configured alert rules
- Forward alerts to Alertmanager

Documentation:

```text
monitoring/prometheus/prometheus.txt
```

---

# Grafana

Grafana is used to visualize metrics collected by Prometheus.

Flow:

```text
Prometheus
     |
     v
Grafana
     |
     v
Dashboards
```

Grafana provides dashboards for monitoring the environment.

Documentation:

```text
monitoring/grafana/grafana.txt
```

---

# Alertmanager

Alertmanager receives alerts from Prometheus and handles alert routing.

Flow:

```text
Prometheus
    |
    v
Alertmanager
    |
    v
Email
```

Responsibilities:

- Receive alerts
- Group alerts
- Route alerts
- Send notifications
- Handle alert delivery

Documentation:

```text
monitoring/alertmanager/alertmanager.txt
```

---

# 📧 Email Alerts

Email alert flow:

```text
Application / Kubernetes
          |
          v
      Prometheus
          |
       Alert Rule
          |
          v
     Alertmanager
          |
          v
      Email Alert
```

The configured monitoring conditions can trigger notifications through
Alertmanager.

---

# 🔐 Security

Security practices used in the project include:

```text
Jenkins Credentials
SonarQube Quality Gate
Nexus Authentication
DockerHub Authentication
Kubernetes RBAC
AWS Security Groups
Terraform State Protection
```

Sensitive information must never be committed to GitHub.

Do not commit:

```text
*.pem
terraform.tfstate
terraform.tfstate.backup
.aws/
credentials
AWS access keys
Passwords
API tokens
DockerHub access tokens
Nexus passwords
SonarQube tokens
Kubernetes secrets
```

---

# .gitignore

Recommended entries:

```gitignore
# Terraform
.terraform/
*.tfstate
*.tfstate.*
*.tfvars
*.tfvars.json
crash.log
crash.*.log

# SSH
*.pem

# AWS
.aws/
credentials

# Environment files
.env
.env.*

# Secrets
secrets/
credentials/
```

---

# 📁 Final GitHub Repository Structure

```text
enterprise-devsecops/
│
├── terraform/
│   ├── main.tf
│   ├── outputs.tf
│   └── terraform.txt
│
├── ansible/
│   ├── ansible.cfg
│   ├── inventory
│   ├── ansible.txt
│   └── playbooks/
│       ├── common.yml
│       ├── docker.yml
│       └── kubernetes.yml
│
├── jenkins/
│   ├── jenkins.txt
│   └── pipeline.txt
│
├── docker/
│   ├── Dockerfile
│   └── docker.txt
│
├── k8s/
│   ├── k8s-master.txt
│   ├── k8s-worker.txt
│   ├── deployment.yaml
│   └── service.yaml
│
├── monitoring/
│   ├── prometheus/
│   │   └── prometheus.txt
│   ├── grafana/
│   │   └── grafana.txt
│   └── alertmanager/
│       └── alertmanager.txt
│
├── helm/
│   └── helm.txt
│
├── dockerhub/
│   └── dockerhub.txt
│
├── sonarqube/
│   └── sonarqube.txt
│
├── nexus/
│   └── nexus.txt
│
├── pom.xml
├── .gitignore
└── README.md
```

---

# 🔁 Complete End-to-End DevSecOps Workflow

```text
                              Developer
                                  |
                                  v
                               GitHub
                                  |
                                  v
                               Jenkins
                                  |
                    +-------------+-------------+
                    |                           |
                    v                           v
                Maven Build               SonarQube
                    |                           |
                    |                      Quality Gate
                    |                           |
                    +-------------+-------------+
                                  |
                                  v
                                Nexus
                                  |
                                  v
                            Docker Build
                                  |
                                  v
                              DockerHub
                                  |
                                  v
                             Kubernetes
                                  |
                       +----------+----------+
                       |                     |
                       v                     v
                  K8s Master            K8s Worker
                                             |
                                             v
                                      Application Pods
                                             |
                                             v
                                        Prometheus
                                       /          \
                                      v            v
                                  Grafana      Alertmanager
                                                   |
                                                   v
                                               Email Alerts
```

---

# 🧪 Verification Commands

## Terraform

```bash
terraform version
terraform init
terraform validate
terraform fmt
terraform plan
terraform state list
terraform output
```

## Ansible

```bash
ansible --version
ansible-inventory --graph
ansible all -m ping
ansible-playbook playbooks/common.yml
ansible-playbook playbooks/docker.yml
ansible-playbook playbooks/kubernetes.yml
```

## Docker

```bash
docker --version
docker ps
docker images
docker info
```

## DockerHub

```bash
docker images
docker login
docker push revanth76/enterprise-devsecops:<BUILD_NUMBER>
```

## Kubernetes

```bash
kubectl version --client
kubectl get nodes
kubectl get pods -o wide
kubectl get deployments
kubectl get services
```

## Helm

```bash
helm version
helm list
helm repo list
```

## Monitoring

Prometheus, Grafana, and Alertmanager should be verified from their respective
web interfaces and service status commands.

---

# 🔍 Troubleshooting

## Terraform

Check plan before applying:

```bash
terraform plan
```

Never blindly apply changes to an existing infrastructure.

---

## Ansible

Test connectivity:

```bash
ansible all -m ping -vvv
```

Check inventory:

```bash
ansible-inventory --graph
```

---

## Jenkins

Check:

```text
JDK tool name
Maven tool name
SonarQube server configuration
Nexus credentials
DockerHub credentials
Maven managed settings
Docker permissions
kubectl authentication
```

Required Jenkins tool names:

```text
JDK21
Maven
```

Required Jenkins credentials:

```text
nexus-creds
jenkins-devsecops
```

Required Maven managed file:

```text
maven-settings
```

---

## SonarQube Quality Gate Timeout

Check:

```text
SonarQube server
Jenkins SonarQube configuration
SonarQube webhook
Network connectivity
Quality Gate status
```

---

## Nexus Authentication Error

Check:

```text
nexus-creds
maven-settings
settings.xml
pom.xml
Nexus repository permissions
```

---

## Docker Permission Error

Check Docker:

```bash
sudo systemctl status docker
```

Test:

```bash
docker ps
```

---

## Kubernetes Access Error

Check:

```bash
kubectl get nodes
```

Verify that the Jenkins execution environment has valid Kubernetes
authentication and network connectivity to the Kubernetes API.

---

# 📈 Project Outcome

This project demonstrates an end-to-end enterprise DevSecOps implementation on
AWS.

## Infrastructure

```text
AWS
Terraform
Ansible
```

## CI/CD

```text
GitHub
Jenkins
Maven
```

## Code Quality

```text
SonarQube
Quality Gate
```

## Artifact Management

```text
Nexus
```

## Containerization

```text
Docker
DockerHub
```

## Orchestration

```text
Kubernetes
Helm
```

## Monitoring

```text
Prometheus
Grafana
Alertmanager
```

## Notifications

```text
Email Alerts
```

---

# 🎯 Key Project Achievements

- Designed an enterprise-style DevSecOps architecture on AWS.
- Managed existing AWS infrastructure using Terraform.
- Imported existing Kubernetes EC2 instances into Terraform state.
- Verified infrastructure using Terraform plan and state.
- Automated common server configuration using Ansible.
- Verified SSH connectivity to all three servers.
- Used Docker on the DevSecOps server.
- Preserved containerd on Kubernetes master and worker nodes.
- Built a Jenkins CI/CD pipeline.
- Integrated GitHub with Jenkins.
- Integrated Maven for Java WAR packaging.
- Integrated SonarQube for static code analysis.
- Implemented SonarQube Quality Gate validation.
- Published Maven artifacts to Nexus.
- Containerized the application using Docker.
- Published Docker images to DockerHub.
- Used Jenkins BUILD_NUMBER for image versioning.
- Deployed the application to Kubernetes.
- Used Kubernetes Deployment with two replicas.
- Exposed the application through NodePort.
- Used Helm as Kubernetes package management tooling.
- Implemented Prometheus monitoring.
- Implemented Grafana dashboards.
- Configured Alertmanager for alert routing.
- Implemented email alert notifications.
- Documented the complete DevSecOps lifecycle.

---

# 💼 Interview Explanation

A concise interview explanation:

> I built an Enterprise DevSecOps CI/CD platform on AWS using Terraform and
> Ansible for infrastructure and configuration management. Jenkins handles the
> CI/CD workflow, Maven builds the Java WAR application, SonarQube performs
> static code analysis, and the Quality Gate controls whether the pipeline can
> continue. Nexus stores the Maven artifact. Docker containerizes the
> application and DockerHub stores the Docker image. Jenkins then updates the
> Kubernetes Deployment with the new image. The application runs on a
> Kubernetes master-worker cluster, while Prometheus and Grafana provide
> monitoring and Alertmanager sends email notifications for configured alerts.

---

# 🏆 Final Architecture Summary

```text
AWS
│
├── DevSecOps Server
│   │
│   ├── Terraform
│   ├── Ansible
│   ├── Jenkins
│   ├── Maven
│   ├── SonarQube
│   ├── Nexus
│   ├── Docker
│   ├── DockerHub
│   └── Helm
│
├── Kubernetes Master
│   │
│   ├── Kubernetes Control Plane
│   ├── containerd
│   ├── kubelet
│   ├── Prometheus
│   ├── Grafana
│   └── Alertmanager
│
└── Kubernetes Worker
    │
    ├── Kubernetes Worker Node
    ├── containerd
    ├── kubelet
    └── Application Pods
```

---

# 📊 Technology Stack

| Category | Technology |
|---|---|
| Cloud | AWS |
| Infrastructure as Code | Terraform |
| Configuration Management | Ansible |
| Source Control | GitHub |
| CI/CD | Jenkins |
| Build Tool | Maven |
| Code Quality | SonarQube |
| Quality Control | SonarQube Quality Gate |
| Artifact Repository | Nexus |
| Containerization | Docker |
| Container Registry | DockerHub |
| Orchestration | Kubernetes |
| Package Manager | Helm |
| Monitoring | Prometheus |
| Visualization | Grafana |
| Alerting | Alertmanager |
| Notification | Email |
| Application Server | Apache Tomcat |
| Application Packaging | WAR |
| Container Runtime | Docker / containerd |

---

# 📚 Documentation Map

Each major component has its own documentation inside the repository.

```text
terraform/terraform.txt
    -> Terraform installation, configuration and commands

ansible/ansible.txt
    -> Ansible installation, inventory, configuration and playbooks

jenkins/jenkins.txt
    -> Jenkins installation and configuration

jenkins/pipeline.txt
    -> Complete Jenkins pipeline and stage explanation

docker/docker.txt
    -> Docker installation and commands

sonarqube/sonarqube.txt
    -> SonarQube installation and configuration

nexus/nexus.txt
    -> Nexus installation and configuration

dockerhub/dockerhub.txt
    -> DockerHub setup and image publishing

k8s/k8s-master.txt
    -> Kubernetes master installation and configuration

k8s/k8s-worker.txt
    -> Kubernetes worker installation and configuration

helm/helm.txt
    -> Helm installation and commands

monitoring/prometheus/prometheus.txt
    -> Prometheus installation and configuration

monitoring/grafana/grafana.txt
    -> Grafana installation and configuration

monitoring/alertmanager/alertmanager.txt
    -> Alertmanager installation, configuration and email alerts
```

---

# 🔐 Production Security Considerations

For a production environment, the following improvements are recommended:

- Use private subnets for internal infrastructure.
- Use IAM roles instead of long-lived AWS credentials.
- Store secrets in AWS Secrets Manager or Parameter Store.
- Use HTTPS/TLS for application and management interfaces.
- Use Kubernetes RBAC with least privilege.
- Use private Docker registries or image-scanning policies.
- Enable centralized logging.
- Use encrypted storage.
- Protect Terraform state using a remote backend and locking.
- Use Jenkins credential management for all secrets.
- Use SSH key management and strict host-key verification.
- Restrict Security Group rules to required source networks.
- Use image vulnerability scanning.
- Use signed container images where required.

---

# 🚀 Future Improvements

Possible future enhancements:

```text
AWS Load Balancer
Ingress Controller
TLS / HTTPS
Private Subnets
AWS Secrets Manager
ECR
EKS
Terraform Remote Backend
S3 State Storage
DynamoDB State Locking
Trivy Image Scanning
OWASP Dependency Check
Centralized Logging
ELK / OpenSearch
Blue-Green Deployment
Canary Deployment
GitHub Webhooks
Argo CD / GitOps
```

---

# 📋 Final Project Checklist

```text
[✓] AWS Infrastructure
[✓] Terraform
[✓] Terraform State Management
[✓] Ansible
[✓] Ansible Inventory
[✓] Common Server Configuration
[✓] Docker Runtime
[✓] Kubernetes containerd Runtime
[✓] Jenkins
[✓] GitHub Checkout
[✓] Maven Build
[✓] SonarQube
[✓] Quality Gate
[✓] Nexus
[✓] Docker Build
[✓] DockerHub Login
[✓] Docker Tag
[✓] Docker Push
[✓] Kubernetes Deployment
[✓] Kubernetes Service
[✓] Helm
[✓] Prometheus
[✓] Grafana
[✓] Alertmanager
[✓] Email Alerts
[✓] Project Documentation
[✓] GitHub Repository Structure
```

---

# 📌 Final Repository Structure

```text
enterprise-devsecops/
│
├── terraform/
│   ├── main.tf
│   ├── outputs.tf
│   └── terraform.txt
│
├── ansible/
│   ├── ansible.cfg
│   ├── inventory
│   ├── ansible.txt
│   └── playbooks/
│       ├── common.yml
│       ├── docker.yml
│       └── kubernetes.yml
│
├── jenkins/
│   ├── jenkins.txt
│   └── pipeline.txt
│
├── docker/
│   ├── Dockerfile
│   └── docker.txt
│
├── k8s/
│   ├── k8s-master.txt
│   ├── k8s-worker.txt
│   ├── deployment.yaml
│   └── service.yaml
│
├── monitoring/
│   ├── prometheus/
│   │   └── prometheus.txt
│   ├── grafana/
│   │   └── grafana.txt
│   └── alertmanager/
│       └── alertmanager.txt
│
├── helm/
│   └── helm.txt
│
├── dockerhub/
│   └── dockerhub.txt
│
├── sonarqube/
│   └── sonarqube.txt
│
├── nexus/
│   └── nexus.txt
│
├── pom.xml
├── .gitignore
└── README.md
```

---

# 🎓 Interview Skills Demonstrated

This project demonstrates practical knowledge of:

```text
AWS
Linux
Git
GitHub
Terraform
Infrastructure as Code
Ansible
Configuration Management
Jenkins
CI/CD
Maven
Java WAR Packaging
SonarQube
Static Code Analysis
Quality Gates
Nexus
Artifact Management
Docker
Containerization
DockerHub
Kubernetes
Pods
Deployments
Services
NodePort
Helm
Prometheus
Grafana
Alertmanager
Email Alerting
DevSecOps
Cloud Automation
Monitoring
Troubleshooting
```

---

# 🏁 Conclusion

The Enterprise DevSecOps CI/CD Platform demonstrates a complete automated
software delivery lifecycle from source code to production-style Kubernetes
deployment and monitoring.

The complete workflow is:

```text
Infrastructure
      |
      v
Terraform
      |
      v
Ansible
      |
      v
GitHub
      |
      v
Jenkins
      |
      v
Maven
      |
      v
SonarQube
      |
      v
Quality Gate
      |
      v
Nexus
      |
      v
Docker
      |
      v
DockerHub
      |
      v
Kubernetes
      |
      v
Application Pods
      |
      v
Prometheus
      |
      v
Grafana
      |
      v
Alertmanager
      |
      v
Email Alerts
```

---

# ✅ Project Status

```text
Terraform              ✅ Completed
Ansible                ✅ Completed
Jenkins                ✅ Completed
Maven                  ✅ Completed
SonarQube              ✅ Completed
Quality Gate           ✅ Completed
Nexus                  ✅ Completed
Docker                 ✅ Completed
DockerHub              ✅ Completed
Kubernetes             ✅ Completed
Helm                   ✅ Completed
Prometheus             ✅ Completed
Grafana                ✅ Completed
Alertmanager           ✅ Completed
Email Alerts           ✅ Completed
Documentation          ✅ Completed
```

---

## Enterprise DevSecOps CI/CD Platform

**Infrastructure → Configuration → Build → Code Quality → Artifact → Container → Deployment → Monitoring → Alerting**

# 🚀 Project Complete
