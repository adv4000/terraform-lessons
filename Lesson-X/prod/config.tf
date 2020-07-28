terraform {
  backend "s3" {
    bucket = "adv-it.xyz"               // Bucket where to SAVE Terraform State
    key    = "prod/terraform.tfstate"   // Object name in the bucket to SAVE Terraform State
    region = "us-west-2"                // Region where bucket created
  }
}