
# #Create Security Group for Load balancer
resource "aws_security_group" "loadbalancer_sg" {
  name        = "loadbalancer_sg"
  description = "Allow http and https"
  vpc_id      = local.vpc_id
  
  ingress {
    description = "allow http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    description = "allow registraion app"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  
   }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "loadbalancer"
  }
}

#Security group for https (for both front app)
resource "aws_security_group" "frontend_app_sg" {
  name        = "frontend"
  description = "Allow http ans https"
  vpc_id      = local.vpc_id

  ingress {
    description     = "allow http"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.loadbalancer_sg.id]
  }

  ingress {
    description     = "allow https"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.loadbalancer_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "frontend-app"
  }
}

#Security group for registration app
resource "aws_security_group" "registration_app" {
  name        = "registration_app"
  description = "Allow http ans https"
  vpc_id      = local.vpc_id

  ingress {
    description     = "allow load balancer"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.loadbalancer_sg.id]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "registration-app"
  }
}