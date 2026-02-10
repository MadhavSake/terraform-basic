Create one VM(Ubuntu) and run the following commands on vm

#For ubuntu 

cat /etc/os-release
terraform
sudo apt update && sudo apt upgrade -y
sudo apt install -y wget unzip gnupg

wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com focal main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update

sudo apt install -y terraform

terraform -v

## Create one service account for terraform now I provide owner access  but provide required access.

## download json file of this service account and paste it in the bastion host with .tf files and update file name in the provider.tf 

## Create bucket manually and update bucket name in backend.tf

terraform init

terraform plan

terraform apply
