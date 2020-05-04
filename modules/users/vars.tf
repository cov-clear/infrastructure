variable "admins" {
  description = "Map with all the admins"
  type        = map(map(string))
}

variable "continuous_delivery_bots" {
  description = "Map with all the continuous delivery bots"
  type        = map(map(string))
}

variable "developers" {
  description = "Map with all the developers"
  type        = map(map(string))
}
