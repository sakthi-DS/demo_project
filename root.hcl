locals{
    aws_region="ap-south-1"
}
remote_state{
    backend="s3"
    config={
        bucket=get_env("TG_STATE_BUCKET")
        key          = "${path_relative_to_include()}/terraform.tfstate"
        region       = local.aws_region
        encrypt      = true
        use_lockfile = true
    }
}

generate "provider"{
    path="provider.tf" 
    if_exists = "overwrite_terragrunt"

  contents = <<EOF
    provider "aws" {
    region = "${local.aws_region}"
    }
EOF 

}