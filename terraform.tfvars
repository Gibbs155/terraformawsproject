bucket_name = "lamdabucketapi"
myregion    = "us-east-1"
environment = "Dev"
acl         = "public-read-write"

object_acl    = "public-read-write"
object_key    = "sample.txt"
object_source = "object/sample.txt"

lambda_zip_location = "output/lambda_api_function.zip"
source_file         = "scripts/lambda_api_function.py"
function_name       = "AWS_S3_API_Lambda_Fucntion"
lambda_role_name    = "api_role"
assume_role_policy  = "iam/lambda_assume_policy.json"
lambda_policy_name  = "api_policy"
policy              = "iam/lambda_policy.json"
runtime             = "python3.9"

api_role_name          = "apigateway_role"
api_policy_name        = "apigateway_policy"
api_assume_role_policy = "iam/apigateway_assume_policy.json"
api_policy             = "iam/apigateway_policy.json"

api_description         = "Created by Terraform code"
api_name                = "rest_api"
endpoint_types          = "REGIONAL"
path_part               = "rest_api_stage"
http_method             = "GET"
method_authorization    = "NONE"
integration_http_method = "POST"
integration_type        = "AWS"
status_code             = "200"

stage_name      = "rest_api_stage"
apigw_principal = "apigateway.amazonaws.com"
accountId       = "773075230823"

state_bucket_name = "statefile-bucketgibs"

