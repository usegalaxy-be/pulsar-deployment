terraform {
  backend "s3" { // useful ref: https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformUsingObjectStore.htm
    bucket = "usegalaxy-be"
    key    = "pulsar/vib/terraform.tfstate"
    region = "main"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    use_path_style              = true
    skip_metadata_api_check     = true
    # access_key = "set on env::AWS_ACCESS_KEY"
    # secret_key = "set on env::AWS_SECRET_ACCESS_KEY"
    # endpoints = { s3 = "set on env::AWS_S3_ENDPOINT" } 
  }
}

