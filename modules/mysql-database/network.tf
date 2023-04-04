

resource "aws_subnet" "subnet" {
  count = length(var.zones)

  vpc_id     = var.vpc.id
  cidr_block = "10.0.${var.start_network_number + count.index}.0/24"
  availability_zone = var.zones[count.index]

  tags = {
    Name = join("-", [var.env, var.id, "db-subnet-${count.index}"])
    Environment = var.env
  }
}