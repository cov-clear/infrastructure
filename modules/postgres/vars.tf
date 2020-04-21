variable "identifier" {
  description = "A unique name for the database"
}

variable "instance_class" {
  description = "The size of the DB instances (ex: db.m4.medium, etc)"
}

variable "allocated_storage" {
  description = "The total amount of GB to allocate to the DB"
  type        = number
}

variable "storage_encrypted" {
  description = "Should the DB storage be encrypted"
  type        = bool
}

variable "engine_version" {
  description = "The version of PostgreSQL to use"
  default     = "12.2"
}

variable "engine_family" {
  description = "The version family of the engine (ex: postgres12)"
}

variable "db_name" {
  description = "The name of the database"
}

variable "db_user" {
  description = "The name of the root user"
}

variable "db_password" {
  description = "The root password"
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

variable "vpc_id" {
  description = "ID of the VPC"
}

variable "subnet_ids" {
  description = "IDs of the subnets where the db instances should be created"
  type        = list(string)
}

variable "allowed_cidrs" {
  description = "CIDRs with allowed access to the postgreSQL port"
  type        = list(string)
}

variable "multi_az" {
  description = "Should the database be multi_az enabled"
  type        = bool
}

variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true"
  type        = bool
  default     = true
}
