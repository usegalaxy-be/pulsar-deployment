# Needed when no tfstate file is availbale
//import {
//  to = openstack_compute_instance_v2.exec-node[1]
//  id = "6b4ec46a-e3aa-4668-9041-629a8497402d"
//}
//
//import {
//  to = openstack_compute_instance_v2.exec-node[0]
//  id = "90f14766-53fb-4ac0-ad39-9e0d36be5b0f"
//}
//
//import {
//  to = openstack_compute_instance_v2.central-manager
//  id = "eb04adba-253e-4124-88fb-427b8d906fa1"
//}
//
//import {
//  to = openstack_compute_instance_v2.nfs-server
//  id = "11154d5c-ede0-402e-88d5-b2332789d9e9"
//}
//
//import {
//  to = openstack_blockstorage_volume_v2.volume_nfs_data
//  id = "2e195bc3-241f-4f40-8fa1-c2c02acf697e"
//}

//import {
//  to = openstack_images_image_v2.vgcn-image
//  id = "25736d72-f592-4fdb-a65a-1fc48e61975e"
//}

//import {
//  to = openstack_networking_port_v2.central_manager_ip
//  id = "c16ea337-1db2-429f-93a7-c94b55784fc0"
//}
//
import {
  to = openstack_networking_secgroup_v2.egress-public
  id = "dbaed0ec-d37c-496e-8ce6-957f9c4b54b9"
}

import {
  to = openstack_networking_secgroup_rule_v2.egress-public-4
  id = "418cb244-fb6c-463b-88b1-7d29efe3e7e5"
}

import {
  to = openstack_networking_secgroup_rule_v2.egress-public-6
  id = "8535c185-bc57-426a-a674-ccf0340831c6"
}

//
//import {
//  to = openstack_networking_secgroup_v2.ingress-private
//  id = "42e15df4-c2df-4379-b8d4-55d641606d35"
//}
//
//import {
//  to = openstack_networking_secgroup_v2.public-ssh
//  id = "e7e959a9-2b54-4f6f-9e10-9fe216ac8403"
//}

import {
  to = openstack_compute_keypair_v2.my-cloud-key
  id = "pubkey_padge01"
}

