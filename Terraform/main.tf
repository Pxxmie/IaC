# Who is the cloud provider?
provider "aws" {

# location of aws
  region = var.aws-region 

}
# to download required dependencies 
# create a service/resource on the cloud - ec2 on AWS

resource "aws_instance" "prismika-iac-test" {
   ami = var.web-app_ami_id 
   instance_type = var.instance_type_id 
   tags = {
     Name = "tech254-prismika-iac-tf-test"

}



}

