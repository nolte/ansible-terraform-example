variable "variable_map" {
  type="map"
}

resource "local_file" "foo" {
    content     = "${var.variable_map["content"]}"
    filename = "/tmp/test.txt"
}
