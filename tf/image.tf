resource "openstack_images_image_v2" "vgcn-image" {
  name             = var.image["name"]
  image_source_url = var.image["image_source_url"]
  container_format = var.image["container_format"]
  disk_format      = var.image["disk_format"]
}

// Upload virtual machine GPU image via API
// comment this block if the GPU image is already available or if you upload it via the dashboard interface
resource "openstack_images_image_v2" "vgcn-image-gpu" {
  name             = var.gpu_image["name"]
  image_source_url = var.gpu_image["image_source_url"]
  container_format = var.gpu_image["container_format"]
  disk_format      = var.gpu_image["disk_format"]
}
