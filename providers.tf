provider "aws" {
  region  = var.region
  profile = var.profile

  default_tags {
    tags = {
      project = "terraform-assessment"
    }
  }
}

provider "aws" {
  alias   = "us-east-1"
  region  = "us-east-1"
  profile = var.profile

  default_tags {
    tags = {
      project = "terraform-assessment"
    }
  }
}
