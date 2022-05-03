variable "s3_tfstate" {
  type        = string
  description = "S3 State Bucket Name"
  default     = "runninginstancesreport"
}

variable "access_key" {
  type        = string
  description = "access_key"
  default     = ""
}

variable "secret_access_key" {
  type        = string
  description = "secret_access_key"
  default     = ""
}