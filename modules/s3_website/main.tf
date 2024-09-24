resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = templatefile("${path.module}/s3-policy.json", { bucket = aws_s3_bucket.this.bucket })
  depends_on = [ 
    aws_s3_bucket_public_access_block.this
   ]
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "public-read"

  depends_on = [
    aws_s3_bucket_ownership_controls.this,
    aws_s3_bucket_policy.this,
    aws_s3_bucket_public_access_block.this
  ]
}

resource "aws_s3_object" "this" {
  for_each = setsubtract(fileset("${var.code_path}/", "**"), ["index.html"])
  bucket   = aws_s3_bucket.this.bucket
  key      = each.value
  source   = "${var.code_path}/${each.value}"
  etag     = filemd5("${var.code_path}/${each.value}")
}

resource "aws_s3_object" "index" {
  bucket   = aws_s3_bucket.this.bucket
  key      = "index.html"
  source   = "${var.code_path}/index.html"
  content_type = "text/html"
  etag     = filemd5("${var.code_path}/index.html")
}

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket
  index_document {
    suffix = "index.html"
  }

  depends_on = [ 
    aws_s3_object.this
   ]
}