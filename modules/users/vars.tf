variable "developers" {
  description = "List with the usernames of all the developers"
  type        = list(string)
}

variable "machines" {
  description = "Map with all the machines users plus their groups"
  type        = map(list(string))
}
