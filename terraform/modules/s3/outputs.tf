output "bucket_name" {
  description = "The bucket name."
  value = aws_s3_bucket.static.bucket
}
