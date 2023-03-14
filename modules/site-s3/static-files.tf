output "fileset-results" {
  value = fileset(var.path_static_files, "**")
}

#Upload files of your static website
resource "aws_s3_object" "html" {
  for_each = fileset(var.path_static_files, "**/*.html")

  bucket = aws_s3_bucket.site_bucket.bucket
  key    = each.value
  source = "${var.path_static_files}${each.value}"
  etag   = filemd5("${var.path_static_files}${each.value}")
  content_type = "text/html"
}

resource "aws_s3_object" "svg" {
  for_each = fileset(var.path_static_files, "**/*.svg")

  bucket = aws_s3_bucket.site_bucket.bucket
  key    = each.value
  source = "${var.path_static_files}${each.value}"
  etag   = filemd5("${var.path_static_files}${each.value}")
  content_type = "image/svg+xml"
}

resource "aws_s3_object" "css" {
  for_each = fileset(var.path_static_files, "**/*.css")

  bucket = aws_s3_bucket.site_bucket.bucket
  key    = each.value
  source = "${var.path_static_files}${each.value}"
  etag   = filemd5("${var.path_static_files}${each.value}")
  content_type = "text/css"
}

resource "aws_s3_object" "scss" {
  for_each = fileset(var.path_static_files, "**/*.scss")

  bucket = aws_s3_bucket.site_bucket.bucket
  key    = each.value
  source = "${var.path_static_files}${each.value}"
  etag   = filemd5("${var.path_static_files}${each.value}")
  content_type = "text/scss"
}

resource "aws_s3_object" "js" {
  for_each = fileset(var.path_static_files, "**/*.js")

  bucket = aws_s3_bucket.site_bucket.bucket
  key    = each.value
  source = "${var.path_static_files}${each.value}"
  etag   = filemd5("${var.path_static_files}${each.value}")
  content_type = "application/javascript"
}


resource "aws_s3_object" "images" {
  for_each = fileset(var.path_static_files, "**/*.png")

  bucket = aws_s3_bucket.site_bucket.bucket
  key    = each.value
  source = "${var.path_static_files}${each.value}"
  etag   = filemd5("${var.path_static_files}${each.value}")
  content_type = "image/png"
}

resource "aws_s3_object" "json" {
  for_each = fileset(var.path_static_files, "**/*.json")

  bucket = aws_s3_bucket.site_bucket.bucket
  key    = each.value
  source = "${var.path_static_files}${each.value}"
  etag   = filemd5("${var.path_static_files}${each.value}")
  content_type = "application/json"
}

resource "aws_s3_object" "ttf" {
  for_each = fileset(var.path_static_files, "**/*.ttf")

  bucket = aws_s3_bucket.site_bucket.bucket
  key    = each.value
  source = "${var.path_static_files}${each.value}"
  etag   = filemd5("${var.path_static_files}${each.value}")
  content_type = "font/ttf"
}


resource "aws_s3_object" "woff" {
  for_each = fileset(var.path_static_files, "**/*.woff")

  bucket = aws_s3_bucket.site_bucket.bucket
  key    = each.value
  source = "${var.path_static_files}${each.value}"
  etag   = filemd5("${var.path_static_files}${each.value}")
  content_type = "font/woff"
}

resource "aws_s3_object" "woff2" {
  for_each = fileset(var.path_static_files, "**/*.woff2")

  bucket = aws_s3_bucket.site_bucket.bucket
  key    = each.value
  source = "${var.path_static_files}${each.value}"
  etag   = filemd5("${var.path_static_files}${each.value}")
  content_type = "font/woff2"
}

resource "aws_s3_object" "eot" {
  for_each = fileset(var.path_static_files, "**/*.eot")

  bucket = aws_s3_bucket.site_bucket.bucket
  key    = each.value
  source = "${var.path_static_files}${each.value}"
  etag   = filemd5("${var.path_static_files}${each.value}")
  content_type = "application/vnd.ms-fontobject"
}

resource "aws_s3_object" "webmanifest" {
  for_each = fileset(var.path_static_files, "**/*.webmanifest")

  bucket = aws_s3_bucket.site_bucket.bucket
  key    = each.value
  source = "${var.path_static_files}${each.value}"
  etag   = filemd5("${var.path_static_files}${each.value}")
  content_type = "application/manifest+json"
}
