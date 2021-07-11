#!/bin/bash
# This file installs and sets up SLURM as the scheduler for the Raspberry Pi cluster

# Ethernet IP addresses for each Raspberry Pi
master_ip=10.10.10.0
node1_ip=10.10.10.1
node2_ip=10.10.10.2
node3_ip=10.10.10.3
node4_ip=10.10.10.4
node5_ip=10.10.10.5
node6_ip=10.10.10.6
node7_ip=10.10.10.7

cluster_name=clusterphuq
master_hostname="$cluster_name"0
node1_hostname="$cluster_name"1
node2_hostname="$cluster_name"2
node3_hostname="$cluster_name"3
node4_hostname="$cluster_name"4
node5_hostname="$cluster_name"5
node6_hostname="$cluster_name"6
node7_hostname="$cluster_name"7

# Add slave node IP addresses and hostnames to master node
hosts=/etc/hosts
sudo echo -e "$node1_ip\t$node1_hostname" >> "$hosts"
sudo echo -e "$node2_ip\t$node2_hostname" >> "$hosts"
sudo echo -e "$node3_ip\t$node3_hostname" >> "$hosts"
sudo echo -e "$node4_ip\t$node4_hostname" >> "$hosts"
sudo echo -e "$node5_ip\t$node5_hostname" >> "$hosts"
sudo echo -e "$node6_ip\t$node6_hostname" >> "$hosts"
sudo echo -e "$node7_ip\t$node7_hostname" >> "$hosts"

# Install SLURM controller packages
sudo apt -y install slurm-wlm

# Configure SLURM
slurm_dir=/etc/slurm-llnl
slurm_config=slurm.conf
sudo cp /usr/share/doc/slurm-client/examples/"$slurm_config".simple.gz "$slurm_dir"
sudo gzip -d "$slurm_dir"/"$slurm_config".simple.gz
sudo mv "$slurm_dir"/"$slurm_config".simple "$slurm_dir"/"$slurm_config"
sudo sed -i "s;#SlurmctldHost=workstation;SlurmctldHost=$master_hostname($master_ip);" "$slurm_dir"/"$slurm_config"
#sudo echo "SelectType=select/cons_res" >> "$slurm_dir"/"$slurm_config"
#sudo echo "SelectTypeParameters=CR_Core" >> "$slurm_dir"/"$slurm_config"
sudo sed -i "s;#ClusterName=;ClusterName=$cluster_name;" >> "$slurm_dir"/"$slurm_config"
sudo echo "Nodename=$master_hostname NodeAddr=$master_ip CPUs=4 State=UNKNOWN" >> "$slurm_dir"/"$slurm_config"
sudo echo "Nodename=$node1_hostname NodeAddr=$node1_ip CPUs=4 State=UNKNOWN" >> "$slurm_dir"/"$slurm_config"
sudo echo "Nodename=$node2_hostname NodeAddr=$node2_ip CPUs=4 State=UNKNOWN" >> "$slurm_dir"/"$slurm_config"
sudo echo "Nodename=$node3_hostname NodeAddr=$node3_ip CPUs=4 State=UNKNOWN" >> "$slurm_dir"/"$slurm_config"
sudo echo "Nodename=$node4_hostname NodeAddr=$node4_ip CPUs=4 State=UNKNOWN" >> "$slurm_dir"/"$slurm_config"
sudo echo "Nodename=$node5_hostname NodeAddr=$node5_ip CPUs=4 State=UNKNOWN" >> "$slurm_dir"/"$slurm_config"
sudo echo "Nodename=$node6_hostname NodeAddr=$node6_ip CPUs=4 State=UNKNOWN" >> "$slurm_dir"/"$slurm_config"
sudo echo "Nodename=$node7_hostname NodeAddr=$node7_ip CPUs=4 State=UNKNOWN" >> "$slurm_dir"/"$slurm_config"
sudo echo "PartitionName=all Nodes=$cluster_name[1-7] Default=YES MaxTime=INFINITE State=UP" >> "$slurm_dir"/"$slurm_config"
sudo rm "$slurm_dir"/"$slurm_config".simple.gz

# cgroups support
cgroup_config=cgroup.conf
cgroup_allowed_devices=cgroup_allowed_devices_file.conf
sudo touch "$slurm_dir"/"$cgroup_config"
sudo echo 'CgroupMountpoint="/sys/fs/cgroup"' >> "$slurm_dir"/"$cgroup_config"
sudo echo "CgroupAutomount=yes" >> "$slurm_dir"/"$cgroup_config"
sudo echo "CgroupReleaseAgentDir=\"$slurm_dir/cgroup\"" >> "$slurm_dir"/"$cgroup_config"
sudo echo "AllowedDevicesFile=\"$slurm_dir/$cgroup_allowed_devices\"" >> "$slurm_dir"/"$cgroup_config"
sudo echo "ConstrainCores=no" >> "$slurm_dir"/"$cgroup_config"
sudo echo "TaskAffinity=no" >> "$slurm_dir"/"$cgroup_config"
sudo echo "ConstrainRAMSpace=yes" >> "$slurm_dir"/"$cgroup_config"
sudo echo "ConstrainSwapSpace=no" >> "$slurm_dir"/"$cgroup_config"
sudo echo "ConstrainDevices=no" >> "$slurm_dir"/"$cgroup_config"
sudo echo "AllowedRamSpace=100" >> "$slurm_dir"/"$cgroup_config"
sudo echo "AllowedSwapSpace=0" >> "$slurm_dir"/"$cgroup_config"
sudo echo "MaxRAMPercent=100" >> "$slurm_dir"/"$cgroup_config"
sudo echo "MaxSwapPercent=100" >> "$slurm_dir"/"$cgroup_config"
sudo echo "MinRAMSpace=30" >> "$slurm_dir"/"$cgroup_config"

nfs_dir=/mnt/nfs

# whitelist system devices
sudo touch "$slurm_dir"/"$cgroup_allowed_devices"
sudo echo "/dev/null" >> "$slurm_dir"/"$cgroup_allowed_devices"
sudo echo "/dev/urandom" >> "$slurm_dir"/"$cgroup_allowed_devices"
sudo echo "/dev/zero" >> "$slurm_dir"/"$cgroup_allowed_devices"
sudo echo '/dev/sda*' >> "$slurm_dir"/"$cgroup_allowed_devices"
sudo echo '/dev/cpu/*/*' >> "$slurm_dir"/"$cgroup_allowed_devices"
sudo echo '/dev/pts/*' >> "$slurm_dir"/"$cgroup_allowed_devices"
sudo echo "$nfs_dir*" >> "$slurm_dir"/"$cgroup_allowed_devices"

sudo cp "$slurm_dir"/"$slurm_config" "$slurm_dir"/"$cgroup_config" "$slurm_dir"/"$cgroup_allowed_devices" "$nfs_dir" /etc/munge/munge.key "$nfs_dir"

# Start Munge
sudo systemctl enable munge
sudo systemctl start munge

# Start SLURM
sudo systemctl enable slurmd
sudo systemctl start slurmd
sudo systemctl enable slurmctld
sudo systemctl start slurmctld
