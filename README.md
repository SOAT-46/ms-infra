# ms-infra

This repository contains Terraform code for provisioning and managing infrastructure resources 
for a microservices project.

## Description

This repository provides a framework for managing infrastructure using Terraform. It includes:

* **Modules:** Reusable modules for common infrastructure components (e.g., VPCs, subnets, security groups, EC2 instances).
* **Variables:** Customizable variables to control infrastructure configurations.
* **Outputs:** Outputs to retrieve information about the provisioned infrastructure.

## Prerequisites

* **Terraform:** Install Terraform according to the instructions for your operating system. For more details, visit [Install Terraform](https://developer.hashicorp.com/terraform/install)

## Usage

1. **Clone the repository:**

   ```bash
   git clone https://github.com/SOAT-46/ms-infra
   ```

2. **Navigate to the repository directory**

   ```bash
   cd ms-infra/terraform
   ```

3. **Initialize Terraform:**

To download the necessary provider plugins and set up your working directory, run:

   ```bash
   terraform init
   ```

4. **Plan the infrastructure changes:**

To preview the change that Terraform intends to make in your infrastructure, run:

   ```bash
   terraform plan
   ```

5. **Apply the infrastructure changes:**

To apply or modify the infrastructure, run:

   ```bash
   terraform apply
   ```

6. **(Optional) Destroy the infrastructure**

   ```bash
   terraform destroy
   ```

If you want to execute a target module, run:

   ```bash
   terraform apply -target=module.name
   ```

## Commands to improve the development and execution

To format the terraform configuration files to the standard style, run:

   ```bash
   terraform fmt
   ```

To validate the configuration files, run:

   ```bash
   terraform validate
   ```

## Contributing

Contributions are welcome! Please submit a pull request with a clear description of your changes.
