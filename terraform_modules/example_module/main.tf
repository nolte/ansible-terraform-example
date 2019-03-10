variable "target_name" {

}

resource "local_file" "foo" {
    content     = "foo!"
    filename = "${var.target_name}"
}
