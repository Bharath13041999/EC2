variable "key_name" {
    description = " SSH keys to connect to ec2 instance"
    default     =  "my_project_key"
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