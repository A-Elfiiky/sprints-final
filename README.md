## Introduction

The objective of the DevOps Bootcamp Capstone Project is to build a completely automated CI/CD pipeline for a web application that runs on Kubernetes. The project employs a variety of technologies and tools, including Terraform, Ansible, Docker, and Kubernetes, to accomplish this goal.


![Sprints - Projects](https://user-images.githubusercontent.com/117025440/227776241-f5384b3d-fa9b-4bba-b0a9-254a11e7609d.jpeg)


---------------------------------------------------------------------------------------------
## Prerequisites

Prerequisites:

Git

Terraform

Ansible

Docker

Docker Compose

Kubernetes

AWS

Jenkins

-----------------------------------------------------------------------------------------------

## Project setup

- clone the repo to your local machine.
- run the below commands to let Terraform create the needed infra

> terrafrom init 

> terraform plan

> terraform apply | terraform apply --auto-approve 

- Run the below commands to use ansible playbook to dow the follwoing.

    - Install Jenkins on EC2
    - Configure Jenkins access
    - Install dependence / plugins (Docker , aws cli , Kubectl , ETC)

 > anible-playbook -i Inventory-name --private-key key-name playbook.yml
 > ansible-playbook -i '123.123.123.123,' -u ubuntu --private-key / keypair.pem /ansible123.yml
 > ansible-playbook -i '3.231.227.17,' -u ubuntu --private-key /home/ahmed/.aws/final.pem /home/ahmed/sprints-fin/ansible_jenkins_config/tasks/main.yml

 - add aws credentials as a secret text (secert key , access key ,...)
add Github token

- To run the web application and its database, navigate to the flask_app directory and execute "docker compose up" command. Once you have completed the preceding steps, you can then execute the pipeline.

------------------------------------------------------------
## Project summry

- Used Terraform to create VPC with 3 Subnet in 2 AZs, EKS cluster with two nodes, an EC2 machine for Jenkins, ECR and run Ansible playbook for configure Jenkins and plugins.
- Used Ansible to install and configure Jenkins, including necessary plugins and AWS and Kubernetes credentials.
- Forked the MySQL-and-Python repository and created a Docker image for the code.
- Created a Docker compose file for the code and database to run.
- Created Kubernetes deployment files for the Python code and statefulset files for MySQL, with PV and PVCs. Added services, configmaps, and secrets for the code, and used an NGINX controller for ingress.
- Configured Jenkins using pipeline as a code to build from GitHub on every push on all branches (GitHub webhooks) to integrate with Jenkins.
- Built the CI/CD Pipeline using Jenkins.
- Checked out an external project.
- Built new Docker images.
- Pushed the image to ECR.
- Added image to the yml files app and database.
- Deployed Kubernetes manifest files.
- The pipeline is configured to output the URL to the website.
-------------------------------------------------------------------------------------------
## Project Challenges. 

The Capstone Project faced several challenges during its implementation. The challenges are described as follows:

One of the challenges encountered during the project was configuring Jenkins using Ansible playbook to install and configure necessary plugins and credentials for AWS and Kubernetes.

Another challenge faced was configuring EC2 instance and integrating it with EKS cluster. Initially, only the creator of the Amazon EKS cluster had system:masters permissions to configure the cluster. To extend system:masters permissions to other users and roles, the aws-auth ConfigMap had to be added to the configuration of the Amazon EKS cluster. The ConfigMap allows other IAM entities, such as users and roles, to access the Amazon EKS cluster.

- https://aws.amazon.com/premiumsupport/knowledge-center/eks-api-server-unauthorized-error/
- https://aws.amazon.com/premiumsupport/knowledge-center/amazon-eks-cluster-access/
- https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html
----------------------------------------------------------
## Future work 
Monitor the instance, web app and DB by any monitoring tool >> prometheus. 


Auto backup the jenkins configuration / installation to github to save the initialization time.

------------------------------------------------------------------------------------
## Refrances links

- Creating the Amazon EBS CSI driver IAM role for service accounts https://docs.aws.amazon.com/eks/latest/userguide/csi-iam-role.html

- Creating an IAM OIDC provider for your cluster https://docs.aws.amazon.com/eks/latest/userguide/

- enable-iam-roles-for-service-accounts.html
Supported Versions table https://github.com/kubernetes/ingress-nginx#supported-versions-table
