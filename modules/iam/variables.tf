variable "name_prefix" {
  type        = string
  description = "Prefix used for naming all IAM resources"
}

variable "s3_bucket_arns" {
  type        = list(string)
  default     = []
  description = "List of S3 bucket ARNs to grant read/write access to"
}
