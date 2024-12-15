variable "public_key" {
  description = "SSH public key content"
  type        = string
}

variable "versioning" {
    type        = bool
    description = "(Optional) A state of versioning."
    default     = true
}
variable "acl" {
    type        = string
    description = " Defaults to private "
    default     = "private"
}
variable "bucket_prefix" {
    type        = string
    description = "(required since we are not using 'bucket') Creates a unique bucket name beginning with the specified prefix"
    default     = ""
}
variable "tags" {
    type        = map(string)
    description = "(Optional) A mapping of tags to assign to the bucket-----"
    default     = {
        environment = "DEV"
        terraform   = "true"
    }
}