# AWS Infrastructure Provisioning with Terraform

## Overview

This repository contains a production-oriented Terraform configuration to provision a foundational AWS infrastructure stack. The setup follows Infrastructure as Code (IaC) principles to ensure consistency, repeatability, and scalability.

The infrastructure created includes:

* A custom Virtual Private Cloud (VPC)
* Public subnet with internet access
* Internet Gateway and Route Table configuration
* Custom Security Group for controlled access
* EC2 instance deployed within the configured network

This project is designed to demonstrate core cloud networking concepts and DevOps best practices using Terraform.

---

## Architecture

The following components are provisioned and connected:

```
VPC (10.0.0.0/16)
│
├── Public Subnet (10.0.1.0/24)
│   │
│   ├── Internet Gateway
│   ├── Route Table (0.0.0.0/0 → IGW)
│   └── EC2 Instance
│
└── Security Group (SSH/HTTP access control)
```

### Key Design Decisions

* A public subnet is used to allow direct internet access to the EC2 instance
* Routing is explicitly defined via a custom route table
* Security groups enforce controlled inbound and outbound traffic

---

## Prerequisites

Ensure the following are installed and configured:

* Terraform (v1.x or later)
* AWS CLI
* AWS Account with appropriate IAM permissions

Configure credentials using:

```
aws configure
```

---

## Getting Started

### 1. Initialize Terraform

```
terraform init
```

Initializes the working directory and downloads required providers.

---

### 2. Validate Configuration

```
terraform validate
```

Ensures the configuration syntax is correct.

---

### 3. Review Execution Plan

```
terraform plan
```

Displays the resources that will be created.

---

### 4. Apply Configuration

```
terraform apply
```

Type `yes` when prompted to provision the infrastructure.

---

### 5. Access the EC2 Instance

After deployment, retrieve the public IP from Terraform output or AWS console:

```
chmod 400 <key-pair>.pem
ssh -i <key-pair>.pem ec2-user@<public-ip>
```

---

### 6. Destroy Infrastructure

To clean up all resources:

```
terraform destroy
```

---

## Resources Provisioned

### Networking

* `aws_vpc` – Defines an isolated virtual network
* `aws_subnet` – Creates a public subnet within the VPC
* `aws_internet_gateway` – Enables internet connectivity
* `aws_route_table` – Manages routing rules
* `aws_route_table_association` – Associates subnet with route table

### Security

* `aws_security_group` – Controls inbound and outbound traffic

### Compute

* `aws_instance` – Launches an EC2 instance within the subnet

---

## Security Considerations

* Restrict SSH access (`port 22`) to trusted IP ranges instead of `0.0.0.0/0`
* Avoid committing private keys or credentials to version control
* Use IAM roles instead of hardcoded AWS credentials where possible
* Enable logging and monitoring (CloudWatch, VPC Flow Logs) in production

---

## Benefits of Terraform

### Infrastructure as Code

All infrastructure is defined declaratively, eliminating manual configuration.

### Consistency

Ensures identical environments across development, staging, and production.

### Automation

Reduces provisioning time and human error.

### Version Control

Infrastructure changes can be tracked, reviewed, and rolled back using Git.

### Scalability

Easily extend the configuration to support additional resources and environments.

---

## Best Practices Followed

* Modular and readable configuration structure
* Use of tags for resource identification
* Explicit dependency management
* Separation of concerns between networking and compute resources

---

## Potential Enhancements

* Introduce private subnets with NAT Gateway
* Add Application Load Balancer (ALB)
* Implement Auto Scaling Group (ASG)
* Configure remote backend (S3 + DynamoDB) for state management
* Integrate CI/CD pipeline for automated deployments

---

## Troubleshooting

| Issue                  | Resolution                                             |
| ---------------------- | ------------------------------------------------------ |
| SSH connection failure | Verify security group rules and key permissions        |
| Invalid AMI            | Ensure AMI ID matches selected region                  |
| Terraform init errors  | Check internet connectivity and provider configuration |
| Permission issues      | Validate IAM roles and AWS credentials                 |

---

## Conclusion

This project provides a clean and practical implementation of AWS infrastructure provisioning using Terraform. It serves as a strong foundation for building more advanced, production-grade cloud architectures.

---

## Author

Upendra Verma
B.Tech CSE | DevOps Enthusiast

---
