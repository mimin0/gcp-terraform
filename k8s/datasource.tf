data "template_file" "startup" {
  template = file("${path.module}/startup.sh")
}