# README

**Provision Google Kubernetes Engine (GKE) cluster using Terraform**

1) Clone the repo locally
2) cd devops-assignment/terraform-gke
3) Run terraform init;terraform plan;terraform apply

Note: terraform.tfstate will be stored in Cloud Storage bucket (bucket_namish)


**Deploy Cluster Workloads**

1) cd devops-assignment/cluster-workload
2) Run sh ./bootstrap.sh

This will automatically deploy/provision
  - 2 namespaces : monitoring and services
  - deploy frontend and backend applications
  - deploy prometheus and grafana using helm
  - expose grafana to internet
  - display admin password for Grafana login


Frontend URL : http://35.184.187.240/
Grafana URL : http://104.154.68.36:3000/?orgId=1
