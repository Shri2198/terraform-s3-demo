provider "aws"{
  region = var.region
}

resource "aws_s3_bucket" "demo_bucket_example" {
  bucket = "testterraformdemobucket"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "demo_config"{
  bucket = aws_s3_bucket.demo_bucket_example.bucket
  rule {
    apply_server_side_encryption_by_default{
    kms_master_key_id = aws_kms_key.mykey.arn
    sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "demo_versioning" {
  bucket = aws_s3_bucket.demo_bucket_example.bucket
  versioning_configuration{
    status = "Enabled"
  }
}

resource "aws_kms_key" "mykey"{
  deletion_window_in_days = "8"
}

resource "aws_s3_bucket_public_access_block" "publicaccess"{
  bucket = aws_s3_bucket.demo_bucket_example.id
  block_public_acls = false
  block_public_policy = false
}
