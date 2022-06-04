
locals {
  mandatory_tag = {
    line_of_business        = "hospital"
    ado                     = "max"
    tier                    = "WEB"
    operational_environment = upper(terraform.workspace)
    tech_poc_primary        = "udu.udu25@gmail.com"
    tech_poc_secondary      = "udu.udu25@gmail.com"
    application             = "http"
    builder                 = "udu.udu25@gmail.com"
    application_owner       = "kojitechs.com"
    vpc                     = "WEB"
    cell_name               = "WEB"
    component_name          = "kojitechs"

  }
  vpc_id = data.aws_vpc.vpc.id
  public_subnet = [for i in data.aws_subnet.public_subnet: i.id]
   private_subnet = [for i in data.aws_subnet.private_subnet: i.id]
   database_subnet = [for i in data.aws_subnet.database_subnet: i.id]
}