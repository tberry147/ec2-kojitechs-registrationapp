
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "component_name" {
  type    = string
  default = "kojitechs"
}

variable "name" {
  type    = list(any)
  default = ["registration_app1", "registration_app2"]

}

# variable "db_name" {
#   default = "webappdb"
# }

# variable "master_username" {
#   default = "dbadmin"
# }


variable "domain_name" {
  default = {
    default = "iandi.click"
    # sandbox = 
    # staging =
  }
}

variable "subject_alternative_names" {
  type    = list(any)
  default = ["*.iandi.click"]
}