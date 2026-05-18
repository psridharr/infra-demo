variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
}

variable "versioning_enabled" {
  type        = bool
  default     = false
  description = "Enable versioning on the bucket"
}

variable "enable_lifecycle" {
  type        = bool
  default     = false
  description = "Enable lifecycle rules on the bucket"
}

variable "lifecycle_rules" {
  description = "List of lifecycle rules to apply to the bucket"
  type = list(object({
    id      = string
    enabled = bool
    prefix  = optional(string, "")

    transitions = optional(list(object({
      days          = number
      storage_class = string
    })), [])

    expiration_days = optional(number, 0)

    noncurrent_version_transitions = optional(list(object({
      days          = number
      storage_class = string
    })), [])

    noncurrent_version_expiration_days = optional(number, 0)
  }))
  default = []
}

variable "sse_algorithm" {
  type        = string
  default     = "AES256"
  description = "Server-side encryption algorithm (AES256 or aws:kms)"
}

variable "kms_master_key_id" {
  type        = string
  default     = null
  description = "KMS key ID when sse_algorithm is aws:kms"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to apply to the bucket"
}
