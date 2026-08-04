terraform {
    backend "s3" {
        bucket = "sctp-tfstate-ce13"
        key    = "jazlyn/terraform.tfstate"
        region = "us-east-1"
    }
}