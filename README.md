# terraform-aws-3-tier-application

A reusable Terraform module to deploy a production-grade 3-tier application on AWS. This module provisions EC2 instances for frontend and backend tiers, IAM instance profiles for SSM-based access, and supports dynamic input configurations.

## Features

- Frontend and backend EC2 instances
- Database instance
- SSM-compatible IAM instance profiles (no SSH needed)
- Security groups with tiered access

---

## Usage

```hcl
module "frontend" {
  source = "nagarajurahul/3-tier-application/aws"

  vpc_id          = var.vpc_id
  subnet_ids      = var.public_subnet_ids
  username        = var.username
  password        = var.password
  env             = "dev"
  owner           = "owner-name"
  skip_final_snapshot = false
  deletion_protection = true
  rds_multi_az    = false
  backend_port    = 3000
}
