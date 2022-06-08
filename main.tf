
# Create Instance
resource "aws_instance" "frontend_app1" {
  ami                    = data.aws_ami.ami.id
  instance_type          = var.instance_type
  subnet_id              = local.private_subnet[0]
  iam_instance_profile   = local.instance_profile
  vpc_security_group_ids = [aws_security_group.loadbalancer_sg.id]
  user_data              = file("${path.module}/template/frontend_app1.sh")

  tags = {
    Name = "frontend_app2"
  }
}

# # # Create Instance
resource "aws_instance" "frontend_app2" {
  ami                    = data.aws_ami.ami.id
  instance_type          = var.instance_type
  subnet_id              = local.private_subnet[1]
  iam_instance_profile   = local.instance_profile
  vpc_security_group_ids = [aws_security_group.frontend_app_sg.id]
  user_data              = file("${path.module}/template/frontend_app2.sh")

  tags = {
    Name = "frontend_app2"
  }
}

#### Registration App (secu from registration app)
resource "aws_instance" "registration_app" {

  depends_on = [module.aurora]
  count      = length(var.name)

  ami                    = data.aws_ami.ami.id
  instance_type          = var.instance_type
  subnet_id              = element(local.private_subnet, count.index)
  iam_instance_profile   = local.instance_profile
  vpc_security_group_ids = [aws_security_group.registration_app.id]
  user_data = templatefile("${path.module}/template/registration_app.tmpl",
    {
      endpoint = module.aurora.cluster_endpoint
      port = module.aurora.cluster_port
      db_name = module.aurora.cluster_database_name
      db_user = module.aurora.cluster_master_username
      db_password = module.aurora.cluster_master_password

  }
  )

  tags = {
    Name = var.name[count.index]
  }
}