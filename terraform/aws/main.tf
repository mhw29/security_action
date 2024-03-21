provider "aws" {
    region = "us-east-1" 
}

resource "aws_ecr_repository" "this" {
        name                 = "security_action"
        image_tag_mutability = "MUTABLE"
}

resource "aws_s3_bucket" "this" {
        bucket = "cn-security-action"
        acl    = "private"
}



