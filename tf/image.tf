data "openstack_images_image_v2" "vgcn-image" {
  name = "${var.image["name"]}"
  most_recent = true
}

//data "openstack_images_image_v2" "vgcn-image-gpu" {
//  name = "${var.gpu_image["name"]}"
//  most_recent = true
//}

resource "openstack_images_image_v2" "vgcn-image-gpu" {
  name             = var.gpu_image["name"]
  image_source_url = var.gpu_image["image_source_url"]
  container_format = var.gpu_image["container_format"]
  disk_format      = var.gpu_image["disk_format"]
}