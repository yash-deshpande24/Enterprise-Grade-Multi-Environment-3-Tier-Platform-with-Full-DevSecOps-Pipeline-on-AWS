terraform {
  backend "s3" {
    bucket         = "myapp-terraform-state-208805233492"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "myapp-terraform-locks"
    encrypt        = true
  }
}
