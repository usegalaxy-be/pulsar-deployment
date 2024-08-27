#!/bin/bash

# Output file
IMPORTS_FILE="imports.tf"
> $IMPORTS_FILE  # Clear the file if it exists

# Generate the Terraform plan
terraform plan -out=tfplan

# Get a list of all resource addresses and names from the Terraform plan
RESOURCES=$(terraform show -json tfplan | jq -r '.planned_values.root_module.resources[] | select(.values.name != null) | "\(.address) \(.values.name)"')

# Function to generate an import block and append to the imports file
generate_import_block() {
    local RESOURCE_ADDRESS=$1
    local RESOURCE_ID=$2

    echo "import {" >> $IMPORTS_FILE
    echo "  to = ${RESOURCE_ADDRESS}" >> $IMPORTS_FILE
    echo "  id = ${RESOURCE_ID}" >> $IMPORTS_FILE
    echo "}" >> $IMPORTS_FILE
    echo "" >> $IMPORTS_FILE
}

# Function to retrieve and process OpenStack resources
process_openstack_resources() {
    local RESOURCE_TYPE=$1
    local OPENSTACK_COMMAND=$2

    echo "Processing $RESOURCE_TYPE..."
    
    # Run the OpenStack command to get resource names and IDs
    while IFS= read -r os_line; do
        OS_RESOURCE_NAME=$(echo $os_line | awk '{print $2}')
        RESOURCE_ID=$(echo $os_line | awk '{print $1}')

        # Loop through each Terraform resource
        while IFS= read -r tf_line; do
            RESOURCE_ADDRESS=$(echo $tf_line | awk '{print $1}')
            TF_RESOURCE_NAME=$(echo $tf_line | awk '{print $2}')

            echo "$OS_RESOURCE_NAME"
            echo "$TF_RESOURCE_NAME"

            # Check if the resource name from OpenStack matches the Terraform resource name
            if [ "$OS_RESOURCE_NAME" = "$TF_RESOURCE_NAME" ]; then
                generate_import_block "$RESOURCE_ADDRESS" "$RESOURCE_ID"
            fi
        done <<< "$RESOURCES"

    done <<< "$($OPENSTACK_COMMAND -f value -c ID -c Name)"
}

# List of OpenStack resources to process
process_openstack_resources "openstack_compute_instance_v2" "openstack server list"
process_openstack_resources "openstack_networking_network_v2" "openstack network list"
process_openstack_resources "openstack_networking_subnet_v2" "openstack subnet list"
process_openstack_resources "openstack_networking_router_v2" "openstack router list"
process_openstack_resources "openstack_networking_floatingip_v2" "openstack floating ip list"
process_openstack_resources "openstack_blockstorage_volume_v3" "openstack volume list"
process_openstack_resources "openstack_images_image_v2" "openstack image list"
process_openstack_resources "openstack_networking_port_v2" "openstack port list"
process_openstack_resources "openstack_networking_secgroup_rule_v2" "openstack security group list"
# process_openstack_resources "openstack_compute_keypair_v2" "openstack keypair list"
# process_openstack_resources "openstack_lb_loadbalancer_v2" "openstack loadbalancer list"
# process_openstack_resources "openstack_orchestration_stack_v1" "openstack stack list"
# process_openstack_resources "openstack_dns_zone_v2" "openstack zone list"
# process_openstack_resources "openstack_identity_project_v3" "openstack project list"
# process_openstack_resources "openstack_identity_user_v3" "openstack user list"
# process_openstack_resources "openstack_identity_role_v3" "openstack role list"
# process_openstack_resources "openstack_compute_hypervisor_v2" "openstack hypervisor list"
# process_openstack_resources "openstack_objectstorage_container_v1" "openstack container list"
# process_openstack_resources "openstack_baremetal_node_v1" "openstack baremetal node list"

echo "imports.tf file has been created with all OpenStack resources."
