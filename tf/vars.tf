// Change this file according to your cloud infrastructure and personal settings
// All variables in < > should be checked and personalized

variable "nfs_disk_size" {
  default = 500
}


### Flavors

# +----+-----------------+--------+------+-----------+-------+-----------+
# | ID | Name            |    RAM | Disk | Ephemeral | VCPUs | Is Public |
# +----+-----------------+--------+------+-----------+-------+-----------+
# | 0  | CPUv1.nano      |     64 |    1 |         0 |     1 | True      |
# | 1  | CPUv1.tiny      |    512 |   10 |         0 |     1 | True      |
# | 10 | UPSv1.medium    |   4096 |   30 |         0 |     2 | True      |
# | 11 | UPSv1.large     |   8192 |   40 |         0 |     4 | True      |
# | 12 | UPSv1.2xlarge   |  61440 |   40 |         0 |    16 | True      |
# | 13 | GPUv2.small     |   2048 |   20 |         0 |     1 | True      |
# | 14 | GPUv2.medium    |   4096 |   30 |         0 |     2 | True      |
# | 15 | GPUv2.large     |   8192 |   40 |         0 |     4 | True      |
# | 16 | GPUv2.2xlarge   |  61440 |   40 |         0 |    16 | True      |
# | 17 | UPSv1.3xlarge   | 122880 |   80 |         0 |    16 | True      |
# | 18 | CPUv1.1_3xlarge | 184320 |   80 |         0 |    14 | True      |
# | 19 | CPUv1.4xlarge   | 368640 |   80 |         0 |    20 | True      |
# | 2  | CPUv1.small     |   2048 |   20 |         0 |     1 | True      |
# | 20 | GPUv3.small     |   2048 |   20 |         0 |     1 | True      |
# | 21 | GPUv3.medium    |   4096 |   30 |         0 |     2 | True      |
# | 22 | GPUv3.large     |   8192 |   40 |         0 |     4 | True      |
# | 23 | GPUv3.2xlarge   |  61440 |   40 |         0 |    16 | True      |
# | 3  | CPUv1.medium    |   4096 |   30 |         0 |     2 | True      |
# | 4  | CPUv1.large     |   8192 |   40 |         0 |     4 | True      |
# | 5  | CPUv1.xlarge    |  16384 |   40 |         0 |     8 | True      |
# | 6  | CPUv1.2xlarge   |  61440 |   40 |         0 |    16 | True      |
# | 7  | CPUv1.3xlarge   | 122880 |   80 |         0 |    16 | True      |
# | 8  | CPUv1.1_2xlarge |  61440 |   40 |         0 |     8 | True      |
# | 9  | UPSv1.small     |   2048 |   20 |         0 |     1 | True      |
# +----+-----------------+--------+------+-----------+-------+-----------+



variable "flavors" {
  type = map
  default = {
    "central-manager" = "CPUv1.small"
    "nfs-server" = "CPUv1.medium"
    "exec-node" = "CPUv1.2xlarge"
    "gpu-node" = "CPUv1.xlarge"
  }
}

variable "exec_node_count" {
  default = 7
}

variable "gpu_node_count" {
  default = 0
}

variable "image" {
  type = map
  default = {
    "name"             = "vggp-v60-j334-00829423b35b-dev" //"vggp-v60-j340-e3937ea797ed-dev"
    "image_source_url" = "https://usegalaxy.eu/static/vgcn/vggp-v60-j334-00829423b35b-dev.raw" //"https://usegalaxy.eu/static/vgcn/vggp-v60-j340-e3937ea797ed-dev.raw"
    // you can check for the latest image on https://usegalaxy.eu/static/vgcn/ and replace this
    "container_format" = "bare"
    "disk_format"      = "raw"
  }
}

variable "gpu_image" {
  type = map
  default = {
    "name"             = "vggp-v60-j334-00829423b35b-dev" //"vggp-v60-j340-e3937ea797ed-dev"
    "image_source_url" = "https://usegalaxy.eu/static/vgcn/vggp-v60-j334-00829423b35b-dev.raw" // "https://usegalaxy.eu/static/vgcn/vggp-v60-j340-e3937ea797ed-dev.raw"
    // you can check for the latest image on https://usegalaxy.eu/static/vgcn/ and replace this
    "container_format" = "bare"
    "disk_format"      = "raw"
  }
}

variable "public_key" {
  type = map(string)
  default = {
    name = "pubkey_padge01"
    pubkey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCrwzM6qImxM0Qah1V48I+gcHvO0MrbDGgueqX/RqwrFW9fEOORVXBJT2aDHktStsxdLe9BapOuyS1XYfPm/OTvSh7fPZML1WA/D4xIz06rHIVcNvQuDno+NECzK7T3xrHJveOUb6i5TGb03SnqF2ApyzHdy/9h6uwmPpVeEJdfviaXzKQhj0wDVW1MiOpjrRW5Frucp/4fjIXYZQxYGIBBxgGyD0EfP68T0+83sgAOAAmos9KtLJDXUbsg+I8mKzjp+iDkc/eNbo6mpz3ZxxMtjwdJPDWwq088vR5oxyDhIcNz6PhmyifWm3kkUuZ02nUp7M8ELLdtpSah52JoE9Fdzdxv1ZtBs3q08u9/3ysE6fc4/VwO7zNaf/EpT8bR30I/5BGWKkiJsctjrZJTxACspNW6PdjRxJaXqSdHaLi5vK8DCeEZwyyRnJh8TKsOhbd8qrxUEE486LXxxVjtuwIyOtEF8xBiVstALcHPJZQ4rqT6EOc7fzgUygWWqJrTIDwmmAuwvOvTPz3jBVwlmU5Ur92y4M0GBSnretMYJIVVyiwqgp0wcZqDn34xiJ9dbEIPBQyURzi9mOd7CqNJEU0g2AnI2Mb7KfBPRn+GY2/aY8gDHTMc1utEvxmqVGf9eeuislQKqKNgHbta00lbSL8liLt4hrlykKaNE1Q7K69UNw== padge@schlat22"
  }
}

variable "name_prefix" {
  default = "vgcn-pulsar-"
}

variable "name_suffix" {
  default = "-vib"
}

variable "secgroups_cm" {
  type = list
  default = [
    "vgcn-public-ssh",
    "vgcn-ingress-private",
    "vgcn-egress-public",
  ]
}

variable "secgroups" {
  type = list
  default = [
    "vgcn-ingress-private", //Should open at least nfs, 9618 for HTCondor and 22 for ssh
    "vgcn-egress-public",
  ]
}

variable "public_network" {
  default = "public"
}

//variable "public_ip" {
//  default = "193.190.80.53"
//}

variable "private_network" {
  type = map
  default = {
    name        = "VSC_2024_002_vm"
    subnet_name = "VSC_2024_002_vm_pool	"
    cidr4       = "10.113.48.0/24" //  "<192.52.32.0/20>" //This is important to make HTCondor work
  }
}

variable "ssh-port" {
  default = "22"
}

//set these variables during execution terraform apply -var "pvt_key=<~/.ssh/my_private_key>" -var "condor_pass=<MyCondorPassword>"
variable "pvt_key" {}

variable "condor_pass" {}

variable "mq_string" {}

# VM network
variable "central_manager_fixed_ip" {
default = "10.113.48.10"  ## ..6.3 is current condor_head
}
variable "vm_network_id" {
    default = "a213a194-49da-4952-a7d8-ec00ae9faead" // "eaa9426b-cfb7-4b06-aa78-fafb98f87fa8"
}
variable "vm_pool_id" {
    default = "ee58df97-48b4-49dc-a0c0-860757ea1ef8" //"7e90b6c0-29b8-4441-9f50-d47786cfbbec"
}