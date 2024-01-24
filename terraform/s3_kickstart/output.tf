// The name of the bucket.
output "s3_id" {
  value = module.s3_bucket.s3_id
}
// The ARN of the bucket. Will be of format arn:aws:s3:::bucketname.
output "s3_arn" {
  value = module.s3_bucket.s3_arn
}
// The bucket domain name. Will be of format bucketname.s3.amazonaws.com.
output "s3_bucket_domain_name" {
  value = module.s3_bucket.s3_bucket_domain_name
}