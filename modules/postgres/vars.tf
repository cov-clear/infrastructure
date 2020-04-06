variable "identifier" {
  description = "A unique name for the database"
}

variable "instance_class" {
  description = "The size of the DB instances (ex: db.m4.medium, etc)"
  type        = string
}

variable "allocated_storage" {
  description = "The total amount of GB to allocate to the DB"
  type        = number
}

variable "storage_encrypted" {
  description = "Should the DB storage be encrypted"
  type = bool
}

variable "engine_version" {
  description = "The version of PostgreSQL to use"
  type        = string
  default     = "12.2"
}

variable "engine_family" {
  description = "The version family of the engine (ex: postgres12)"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_user" {
  description = "The name of the root user"
  type        = string
}

variable "db_password" {
  description = "The root password"
  type        = string
}

variable "maintenance_window" {
  description = "Window when maintenace tasks should be applied"
  default     = "Mon:00:00-Mon:03:00"
}

variable "backup_window" {
  description = "Time of day when to backup the db"
  default     = "03:00-06:00"
}

variable "backup_retention_period" {
  description = "How long to retain backups for"
  default     = 14
}

variable "subnet_ids" {
  description = "IDs of the subnets where the db instances should be created"
  type        = list(string)
}

variable "multi_az" {
  description = "Should the database be "
}

variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true"
  type = bool
  default = true
}