resource "local_file" "foo" {
    content     = "foo!"
    filename = "/tmp/test.txt"
}
