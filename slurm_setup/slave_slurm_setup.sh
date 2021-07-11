#!/bin/bash

sudo apt install -y slurmd slurm-client

this_ip=`ip -br addr | egrep 'eth0' | egrep -o '([0-9]{,3}\.){3}[0-9]{,3}'`
master_ip=10.10.10.0
node1_ip=10.10.10.1
node2_ip=10.10.10.2
node3_ip=10.10.10.3
node4_ip=10.10.10.4
node5_ip=10.10.10.5
node6_ip=10.10.10.6
node7_ip=10.10.10.7
ip_addrs=("$master_ip" "$node1_ip" "$node2_ip" "$node3_ip" "$node4_ip" "$node5_ip" "$node6_ip" "$node7_ip")
cluster_name=clusterphuq

# Add hostnames and their IP addresses for all other nodes to each node
hosts=/etc/hosts
node_num=0
for ip in "${ip_addrs[@]}"
	do
	
	if [ "$ip" != "$this_ip" ]
		then
		sudo echo -e "$ip\t$cluster_name$node_num" >> "$hosts"
	fi
	
	((node_num += 1))
done

# Copy master node's configuration to each slave node
nfs_dir=/mnt/nfs
slurm_dir=/etc/slurm-llnl
sudo cp "$nfs_dir"/munge.key /etc/munge/munge.key
sudo cp "$nfs_dir"/slurm.conf "$slurm_dir"/slurm.conf
sudo cp "$nfs_dir"/cgroup* "$slurm_dir"

# Enable, start, and test Munge
sudo systemctl enable munge
sudo systemctl start munge
ssh pi@"$cluster_name"0 munge -n | unmunge

# Enable, start, and test SLURM
sudo systemctl enable slurmd
sudo systemctl start slurmd
sinfo
srun --nodes=7 hostname
