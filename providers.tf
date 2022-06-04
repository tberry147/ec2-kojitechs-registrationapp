


# Configure the AWS Provider
provider "aws" {
  region  = var.region
  profile = "default"

  default_tags {
    tags = local.mandatory_tag
  }

}