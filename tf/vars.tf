// Change this file according to your cloud infrastructure and personal settings
// All variables in < > should be checked and personalized

variable "nfs_disk_size" {
  default = 32
}

# Must be available in your OpenStack tenant
variable "flavors" {
  type = map(any)
  default = {
    "central-manager" = "m1.medium"
    "nfs-server"      = "m1.medium"
    "exec-node"       = "m1.xlarge"
    "gpu-node"        = "m1.small"
  }
}

# This can later be increased or decreased without everything redeployed
variable "exec_node_count" {
  default = 2
}

variable "gpu_node_count" {
  default = 0
}

variable "image" {
  type = map(any)
  default = {
//  "name"             = "vggp-v60-j225-1a1df01ec8f3-dev"
    "name"             = "<name for that image>"
//  "image_source_url" = "https://usegalaxy.eu/static/vgcn/vggp-v60-j225-1a1df01ec8f3-dev.raw"
    "image_source_url" = "<url-to-latest-vgcn-image>"
    // you can check for the latest image on https://usegalaxy.eu/static/vgcn/ and replace this
    "container_format" = "bare"
    "disk_format"      = "raw"
  }
}

variable "gpu_image" {
  type = map(any)
  default = {
//  "name"             = "vggp-gpu-v60-j16-4b8cbb05c6db-dev"
    "name"             = "<name for that gpu image>"
//  "image_source_url" = "https://usegalaxy.eu/static/vgcn/vggp-gpu-v60-j16-4b8cbb05c6db-dev.raw"
    "image_source_url" = "<url-to-latest-vgcn-gpu-image>"
    // you can check for the latest image on https://usegalaxy.eu/static/vgcn/ and replace this
    "container_format" = "bare"
    "disk_format"      = "raw"
  }
}

variable "public_key" {
  type = map(any)
  default = {
    name   = "<your_VGCN_key>"
    pubkey = "<your public key>"
  }
}

variable "name_prefix" {
  default = "<vgcn->"
}

variable "name_suffix" {
  default = "<.pulsar>"
}

variable "secgroups_cm" {
  type = list(any)
  default = [
    "<public-ssh>",
    "<ingress-private>",
    "<egress-public>",
  ]
}

variable "secgroups" {
  type = list(any)
  default = [
    "<ingress-private>", //Should open at least nfs, 9618 for HTCondor and 22 for ssh
    "<egress-public>",
  ]
}

# Name of the public network that is already present in your openstack tenant
variable "public_network" {
  default = "<public>"
}

variable "private_network" {
  type = map(any)
  default = {
    name        = "<vgcn-private>"
    subnet_name = "<vgcn-private-subnet>"
    cidr4       = "<192.168.0.0/16>" //This is important to make HTCondor work
  }
}

variable "ssh-port" {
  default = "22"
}

// Set these variables during execution terraform apply -var "pvt_key=<~/.ssh/my_private_key>" 
// -var "condor_pass=<MyCondorPassword>" 
// -var "condor_pass=pyamqp://<your-rabbit-mq-user>:<the-password-we-provided-to-you>@mq.galaxyproject.eu:5671//pulsar/<your-rabbit-mq-vhost>?ssl=1"
variable "pvt_key" {}

variable "condor_pass" {}

variable "mq_string" {}
