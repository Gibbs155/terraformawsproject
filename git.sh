#!/bin/bash
git clone git@github.com:Gibbs155/terraformawsproject.git
# rsync -av --exclude 'terraformawsproject' --exclude '.terraform' ./ ./terraformawsproject/
# robocopy /E /XD terraformawsproject /XD .terraform .\ .\terraformawsproject\ poner rutaq completa en todo
robocopy /E  D:/PROYECTOS-Y-POCS/DATA-ENGINEER-AWS/1-Terraform-AWS-IAM,S3,Lambda,APIGateway,CloudFront/ D:/PROYECTOS-Y-POCS/DATA-ENGINEER-AWS/1-Terraform-AWS-IAM,S3,Lambda,APIGateway,CloudFront/terraformawsproject/
cd terraformawsproject
git add .
git commit -m "Pushing code in github repo"
git push git@github.com:Gibbs155/terraformawsproject.git
