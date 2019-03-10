variable "variable_string" {
  type="string"
}

resource "local_file" "foo" {
    content     = "${var.variable_string}"
    filename = "/tmp/test.txt"
}
