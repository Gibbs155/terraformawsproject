resource "aws_s3_bucket" "api_bucket" {
  bucket = "${var.myregion}-${var.bucket_name}"
  tags = {
    Name        = "${var.myregion}-${var.bucket_name}"
    Environment = "${var.environment}"
  }
}

resource "aws_s3_bucket_ownership_controls" "ownership-control" {
  bucket = aws_s3_bucket.api_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "access-block" {
  bucket = aws_s3_bucket.api_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "api_acl" {
  bucket = aws_s3_bucket.api_bucket.id
  acl    = var.acl
  depends_on = [
    # aws_s3_bucket.api_bucket
    aws_s3_bucket_ownership_controls.ownership-control,
    aws_s3_bucket_public_access_block.access-block
  ]
}

# Subiedno a s3 el archivo
resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.api_bucket.id
  key    = var.object_key
  source = var.object_source
  acl    = var.object_acl
  etag   = filemd5(var.object_source)
  depends_on = [
    aws_s3_bucket.api_bucket
  ]
}