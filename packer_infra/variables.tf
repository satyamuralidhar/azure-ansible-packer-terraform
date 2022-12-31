variable "rsg" {}
variable "location" {}
variable "tags" {
  type        = map(any)
  description = "adding tags for resources by using local function"
}
variable "storage_name" {}