locals {
  object_source = "${path.module}/../../site/web"
  object_zip = "${path.module}/../site/web.zip"
}

resource "aws_s3_bucket" "static_site" {
  bucket = "ivyfae-ivysite-static-site"
}

resource "aws_s3_bucket_website_configuration" "static_site_config" {
  bucket = aws_s3_bucket.static_site.bucket
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

data "archive_file" "static_site" {
  type        = "zip"
  source_dir = local.object_source
  output_path = local.object_zip
}

resource "aws_s3_object" "file_upload" {
  bucket      = aws_s3_bucket.static_site.bucket
  bucket_key_enabled = false
  key = "web"
  source      = data.archive_file.static_site.output_path
  source_hash = data.archive_file.static_site.output_md5
}

