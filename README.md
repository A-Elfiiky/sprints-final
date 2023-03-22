Summary

Web application using modern cloud technologies such as Terraform, AWS EKS, Docker, and Kubernetes. created an EKS cluster, configured an EC2 instance for Jenkins, and created an ECR to store Docker images. I used Ansible to install and configure Jenkins, added AWS and Kubernetes credentials, and created Docker images and compose files for the web application and database. then created Kubernetes files, including a deployment file for the web application and a stateful set for the MySQL database, using PV and PVCs. I also set up an Ingress using NGINX and installed the NGINX Ingress controller. Finally, configured Jenkins using pipeline as code to build and deploy the web application to Kubernetes on every push to GitHub, with output of the website URL.

------------------------------------------------------------
Terraform
Terraform will create the EC2 instance, ECR , and EKS.

- Commands 
>terrafrom init 
>terraform plan 
>terraform apply | terraform apply --auto-approve 

----------------------------------------------------------

Ansible
Install Jenkins on EC2
Configure Jenkins access
Install dependence / plugins (Docker , aws cli , Kubectl , ETC)
- anible-playbook -i Inventory-name --private-key key-name playbook.yml

-------------------------------------------------------------

apply Kuberentes Mainfest
kubectl apply -f [all mainfest ]

-log in to EKS

aws eks --region example_region update-kubeconfig --name cluster_name

-log in to ECR and push images

aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/y1x1a8h4

-----------------------------------------

docker build -t flask-app .

docker tag flask-app:latest public.ecr.aws/y1x1a8h4/flask-app:latest

docker push public.ecr.aws/y1x1a8h4/flask-app:latest

-----------------------------------

Jenkins >> CICD 
add credential Dashboard > Manage Jenkins > Credentials > system > Global credentials (unrestricted) + Add Credentials
add (secert key , access key ,...)
add Github token