resource "openstack_compute_instance_v2" "test-cm" {
    name            = "test-cm"
    flavor_name     = "m1.medium"
    image_name      = "test-vgcn-general"
    key_pair        = "cloud2"
    security_groups = [
        "public-web",
        "public-ssh",
        "public-ping",
        "Public",
        "egress",
    ]
    network         = [
        { name = "galaxy-net" },
    ],
    user_data = "${file("conf/cm.yml")}"
}

resource "openstack_compute_instance_v2" "test-exec-1" {
    name            = "test-exec-1"
    flavor_name     = "m1.medium"
    image_name      = "test-vgcn-general"
    key_pair        = "cloud2"
    security_groups = [
        "public-web",
        "public-ssh",
        "public-ping",
        "Public",
        "egress",
    ]
    network         = [
        { name = "galaxy-net" },
    ],
    user_data = <<-EOF
        #cloud-config
        write_files:
        - content: |
            ETC = /etc/condor
            CONDOR_HOST = ${openstack_compute_instance_v2.test-cm.access_ip_v4}
            ALLOW_WRITE = 10.5.68.0/24, 10.19.0.0/16, 132.230.68.0/24, *.bi.uni-freiburg.de
            ALLOW_READ = $(ALLOW_WRITE)
            ALLOW_ADMINISTRATOR = 10.5.68.0/24, 10.19.0.0/16
            ALLOW_NEGOTIATOR = $(ALLOW_ADMINISTRATOR)
            ALLOW_CONFIG = $(ALLOW_ADMINISTRATOR)
            ALLOW_DAEMON = $(ALLOW_ADMINISTRATOR)
            ALLOW_OWNER = $(ALLOW_ADMINISTRATOR)
            ALLOW_CLIENT = *
            DAEMON_LIST = MASTER, SCHEDD, STARTD
            FILESYSTEM_DOMAIN = bi.uni-freiburg.de
            UID_DOMAIN = bi.uni-freiburg.de
            TRUST_UID_DOMAIN = True
            SOFT_UID_DOMAIN = True
            # run with partitionable slots
            CLAIM_PARTITIONABLE_LEFTOVERS = True
            NUM_SLOTS = 1
            NUM_SLOTS_TYPE_1 = 1
            SLOT_TYPE_1 = 100%
            SLOT_TYPE_1_PARTITIONABLE = True
            ALLOW_PSLOT_PREEMPTION = False
            STARTD.PROPORTIONAL_SWAP_ASSIGNMENT = True
            # enable auto shutdown
            # no, don't, this version is for the BW-Cloud!
            #STARTD_NOCLAIM_SHUTDOWN = 7 * 60
            #DEFAULT_MASTER_SHUTDOWN_SCRIPT = /sbin/poweroff
            # allow some time for job retirement, after draining has been initiated
            # NOTE that this value counts from job START TIME!
            MAXJOBRETIREMENTTIME = (7776000) + (172800)
            # new VMTimeToLive attribute
            STARTD_ATTRS = $(STARTD_ATTRS) MaxShutdownTime VMTimeToLive
            include command into $(ETC)/walltime.cfg : python $(ETC)/meta_walltime.py
            MachineWalltime = (7776000) + (172800)
            MaxShutdownTime = $(MachineStarttime) + $(MachineWalltime)
            VMTimeToLive = \
              ifThenElse( IsUndefined($(MaxShutdownTime)), \
                          2147483647, \
                          ($(MaxShutdownTime:2147483647) - time()) \
                        )
            # END ANSIBLE MANAGED BLOCK
          owner: root:root
          path: /etc/condor/condor_config.local
          permissions: '0644'
        - content: |
            /data           /etc/auto.data          nfsvers=3
            /usr/local      /etc/auto.usrlocal      nfsvers=3
          owner: root:root
          path: /etc/auto.master
          permissions: '0644'
        - content: |
            0       -rw,hard,intr,nosuid,quota      sn01.bi.uni-freiburg.de:/export/data3/galaxy/net/data/&
            1       -rw,hard,intr,nosuid,quota      sn03.bi.uni-freiburg.de:/export/galaxy1/data/&
            2       -rw,hard,intr,nosuid,quota      sn01.bi.uni-freiburg.de:/export/data4/galaxy/net/data/&
            3       -rw,hard,intr,nosuid,quota      sn01.bi.uni-freiburg.de:/export/data5/galaxy/net/data/&
            4       -rw,hard,intr,nosuid,quota      sn03.bi.uni-freiburg.de:/export/galaxy1/data/&
            5       -rw,hard,intr,nosuid,quota      sn03.bi.uni-freiburg.de:/export/galaxy1/data/&
            6       -rw,hard,intr,nosuid,quota      sn03.bi.uni-freiburg.de:/export/galaxy1/data/&
            7       -rw,hard,intr,nosuid,quota      sn03.bi.uni-freiburg.de:/export/galaxy1/data/&
            dnb01   -rw,hard,intr,nosuid,quota      ufr.isi1.public.ads.uni-freiburg.de:/ifs/isi1/ufr/bronze/nfs/denbi/&
            db      -rw,hard,intr,nosuid,quota      sn02.bi.uni-freiburg.de:/export/fdata1/galaxy/net/data/&
          owner: root:root
          path: /etc/auto.data
          permissions: '0644'
        - content: |
            python          sn03.bi.uni-freiburg.de:/export/usr.local/sclx/6/x64/&
            galaxy          sn03.bi.uni-freiburg.de:/export/galaxy1/system/&
            tools           sn03.bi.uni-freiburg.de:/export/galaxy1/system/&
          owner: root:root
          path: /etc/auto.usrlocal
          permissions: '0644'
    EOF
}
