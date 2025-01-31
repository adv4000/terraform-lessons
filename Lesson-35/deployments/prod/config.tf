terraform {
  backend "s3" {
    bucket       = "astahov-terraform-remote-state" # Bucket where to SAVE Terraform State
    key          = "prod/terraform.tfstate"         # Object name in the bucket to SAVE Terraform State
    region       = "ca-west-1"                      # Region where bucket created
    use_lockfile = true
  }
}

provider "aws" {
  region = "ca-west-1" # Region where to create resources

  default_tags {
    tags = {
      Owner   = "Denis Astahov"
      Project = "Terraform From Zero to Professional"
    }
  }
}
