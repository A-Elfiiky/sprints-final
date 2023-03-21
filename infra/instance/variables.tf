variable "INSTANCE_TYPE" {
  type        = string
  description = "instance_type"
}
variable "KEY_PAIR" {
  type = string
}

variable "AMI" {
  description = "AMI"
}

variable "PUBLIC_SUBNET_ID" {
  type = string
}

variable "MAIN_VPC_ID" {
  type = string
}

variable "EGRESS_CIDR" {
  type = string
}

variable "INGRESS_CIDER" {
  type = string
}

variable "USER_DATA" {
  default     = <<-EOF
        #!/bin/bash
        # Install docker
        apt-get update
        apt-get install -y apt-transport-https ca-certificates curl software-properties-common
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        add-apt-repository \
          "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
          $(lsb_release -cs) \
          stable"
        apt-get update
        apt-get install -y docker-ce
        usermod -aG docker ubuntu

        # Install docker-compose
        curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
        chmod +x /usr/local/bin/docker-compose
        apt-get install -y awscli
        sudo usermod -aG docker $USER
        sudo usermod -aG docker jenkins
        sudo usermod -aG docker aws
        newgrp docker
        echo "install kubectl"
        curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.24.10/2023-01-30/bin/linux/amd64/kubectl
        chmod +x ./kubectl
        mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
        kubectl version --short --client
        EOF
  description = "Docker Installation user Data"
}

