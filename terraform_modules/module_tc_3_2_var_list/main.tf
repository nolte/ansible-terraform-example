variable "variable_list" {
  type="list"
}

resource "local_file" "foo" {
    content     = "${join(",", var.variable_list)}"
    filename = "/tmp/test.txt"
}
