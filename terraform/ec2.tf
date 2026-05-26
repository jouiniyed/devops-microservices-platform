data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }
}

resource "aws_key_pair" "devops" {
    key_name = "devops-key"
    public_key = file("~/.ssh/devops_key.pub")
}

resource "aws_instance" "k3s" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t3.medium"
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.k3s.id]
    key_name = aws_key_pair.devops.key_name
    user_data = file("cloud-init.yaml")

    root_block_device {
        volume_size = 20
        volume_type = "gp3"
    }

    tags = { Name = "devops-k3s-node" }
}

resource "aws_eip" "k3s" {
    instance = aws_instance.k3s.id
    domain = "vpc"
    tags = { Name = "devops-eip" }
}