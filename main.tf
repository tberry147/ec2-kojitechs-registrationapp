
# Create Instance
resource "aws_instance" "frontend_app1" {
  ami                    = data.aws_ami.ami.id
  instance_type          = var.instance_type
  subnet_id              = local.private_subnet[0]
  key_name               = data.aws_key_pair.mykey.key_name
  vpc_security_group_ids = [aws_security_group.loadbalancer_sg.id]
  user_data              = file("${path.module}/template/frontend_app1.sh")
}

# # # Create Instance
resource "aws_instance" "frontend_app2" {
  ami                    = data.aws_ami.ami.id
  instance_type          = var.instance_type
  subnet_id              = local.private_subnet[1]
  key_name               = data.aws_key_pair.mykey.key_name
  vpc_security_group_ids = [aws_security_group.frontend_app_sg.id]
  user_data = file("${path.module}/template/frontend_app2.sh")
}


