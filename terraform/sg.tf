resource "aws_security_group" "master" {
  name        = "master-sg"
  description = "master sg"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "master-sg"
  }
}

resource "aws_security_group" "node" {
  name        = "node-sg"
  description = "nodes sg"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "node-sg"
  }
}

# master ingress - ssh
resource "aws_security_group_rule" "master_ingress_ssh" {
  type              = "ingress"
  security_group_id = aws_security_group.master.id
  cidr_blocks       = ["${data.external.my_ip.result.ip}/32"]
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
}

# master egress - http
resource "aws_security_group_rule" "master_egress_http" {
  type              = "egress"
  security_group_id = aws_security_group.master.id
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
}

# master egress - https
resource "aws_security_group_rule" "master_egress_https" {
  type              = "egress"
  security_group_id = aws_security_group.master.id
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
}

# master egress - any allow master to node
resource "aws_security_group_rule" "master_egress_nodes" {
  type                     = "egress"
  security_group_id        = aws_security_group.master.id
  source_security_group_id = aws_security_group.node.id
  protocol                 = "tcp"
  from_port                = 1025
  to_port                  = 65535
}

# node ingress - any allow master to node
resource "aws_security_group_rule" "nodes_ingress_master" {
  type                     = "ingress"
  security_group_id        = aws_security_group.node.id
  source_security_group_id = aws_security_group.master.id
  protocol                 = "tcp"
  from_port                = 1025
  to_port                  = 65535
}

# nodes egress - http
resource "aws_security_group_rule" "nodes_egress_http" {
  type              = "egress"
  security_group_id = aws_security_group.node.id
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
}

# nodes egress - https
resource "aws_security_group_rule" "nodes_egress_https" {
  type              = "egress"
  security_group_id = aws_security_group.node.id
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
}