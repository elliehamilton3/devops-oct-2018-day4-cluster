
resource "aws_subnet" "subnet" {
  vpc_id = "${module.vpc.id}"
  cidr_block = "${element(var.cidrs, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  count = "${length(var.cidrs)}"

  tags {
    Name = "${var.enviroment}"
  }
}

resource "aws_route_table" "subnet" {
  vpc_id = "${module.vpc.id}"

  count = "${length(var.cidrs)}"

  tags {
    Name = "${var.enviroment}"
  }
}

resource "aws_route_table_association" "" {
  subnet_id = "${element(aws_subnet.subnet.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.subnet.*.id, count.index)}"
  count = "${length(var.cidrs)}"
}