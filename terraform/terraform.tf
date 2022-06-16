terraform {
  backend "s3" {
    bucket = "reizist-tfstate"
    key    = "app/terraform.tfstate"
		region = "ap-northeast-1"
  }
}
