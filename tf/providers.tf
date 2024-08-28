terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "1.48.0"
    }
    minio = {
      source = "aminueza/minio"
      version = "2.4.3"
    }
  }
}
