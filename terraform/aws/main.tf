provider "aws" {
    region = "us-east-1" 
}

resource "aws_ecr_repository" "this" {
        name                 = "security_action"
        image_tag_mutability = "MUTABLE"
}



