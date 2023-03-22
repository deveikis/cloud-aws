resource "aws_s3_bucket" "tf-rstate" {
  bucket        = var.s3_bucket_name
  force_destroy = var.s3_bucket_force_destroy

  tags = var.tags
}

resource "aws_s3_bucket_acl" "tf-rstate" {
  bucket = aws_s3_bucket.tf-rstate.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "tf-rstate" {
  bucket = aws_s3_bucket.tf-rstate.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "tf-rstate" {
  bucket                  = aws_s3_bucket.tf-rstate.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf-rstate" {
  bucket = aws_s3_bucket.tf-rstate.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.tf-rstate.arn
    }
  }
}

resource "aws_kms_key" "tf-rstate" {
  description             = var.kms_key_description
  deletion_window_in_days = var.kms_key_deletion_window_in_days
  enable_key_rotation     = var.kms_key_enable_key_rotation

  tags = var.tags
}

resource "aws_kms_alias" "tf-rstate" {
  name          = "alias/${var.kms_key_alias}"
  target_key_id = aws_kms_key.tf-rstate.key_id
}
