#!/usr/bin/env bash
STATE_BUCKET=adt-terraform-state-buckets
AWS_REGION=eu-north-1 # Stockholm region

# Check if bucket exists before creation
if aws s3api head-bucket --bucket $STATE_BUCKET 2>/dev/null; then
  echo "Bucket $STATE_BUCKET already exists. Skipping creation."
else
  aws s3api create-bucket --bucket $STATE_BUCKET --region $AWS_REGION --create-bucket-configuration LocationConstraint=$AWS_REGION
  aws s3api get-public-access-block --bucket adt-terraform-state-buckets
  aws s3api put-bucket-versioning --bucket $STATE_BUCKET --versioning-configuration Status=Enabled
fi
