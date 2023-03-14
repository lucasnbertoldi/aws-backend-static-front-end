


resource "aws_s3_bucket" "site_bucket" {
  bucket = join("-", [var.env, var.id, "site"])

  tags = {
    Environment = var.env
  }

}

resource "aws_s3_bucket_website_configuration" "bucket_website_config" {
  bucket = aws_s3_bucket.site_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_public_access" {
  bucket = aws_s3_bucket.site_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket_public_policy" {
  bucket = aws_s3_bucket.site_bucket.id
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
	  "Principal": "*",
      "Action": [ "s3:*" ],
      "Resource": [
        "${aws_s3_bucket.site_bucket.arn}",
        "${aws_s3_bucket.site_bucket.arn}/*"
      ]
    }
  ]
}
EOF
}

