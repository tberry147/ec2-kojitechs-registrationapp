
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


variable "domain_name" {
  type = map (any)
  }


variable "subject_alternative_domain_name" {
  type    = list
    
}