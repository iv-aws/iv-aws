variable "COMMIT_BRANCH" {
  type = string
}

variable "COMMIT_TIMESTAMP" {
  type = string
}

locals {
  py_version = "python3.10"
  build_id = "${var.COMMIT_TIMESTAMP}-${var.COMMIT_BRANCH}"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

