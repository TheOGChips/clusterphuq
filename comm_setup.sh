#!/bin/bash
# This file installs OpenMPI, mpi4py, sets up NFS, and enables communication between all cluster nodes

# Ethernet IP addresses for each Raspberry Pi
master=10.10.10.0
node1=10.10.10.1
node2=10.10.10.2
node3=10.10.10.3
node4=10.10.10.4
node5=10.10.10.5
node6=10.10.10.6
node7=10.10.10.7

if [ "$1" == 'master' -o "$1" == 'slave' ]
	then
	# Install MPI and mpi4py on all nodes
	sudo apt update
	sudo apt upgrade
	sudo apt -y install openmpi-bin openmpi-common libopenmpi3 libopenmpi-dev # OpenMPI
	pip install mpi4py	# MPI library for Python 2
	pip3 install mpi4py	# MPI library for Python 3

	BASHRC=~/.bashrc
	echo >> "$BASHRC"
	echo '# unset programmable completion (get rid of the annoying $ -> \$ replacement)' >> "$BASHRC"
	echo 'shopt -u progcomp' >> "$BASHRC"

	# Create mount directory for NFS (network file system) on all nodes
	nfs_dir=/mnt/nfs
	sudo mkdir "$nfs_dir"
	sudo chown pi.users -R "$nfs_dir"
	sudo chmod 777 -R "$nfs_dir"
	sudo echo "NFS=$nfs_dir" >> /etc/environment

	# Generate SSH key on all nodes
	ssh-keygen -t rsa
	# NOTE: Press "Enter" for the next 3 questions

	if [ "$1" == 'master' ]
		then
		# The master node will copy its SSH to each slave node
		ssh-copy-id "$node1"
		ssh-copy-id "$node2"
		ssh-copy-id "$node3"
		ssh-copy-id "$node4"
		ssh-copy-id "$node5"
		ssh-copy-id "$node6"
		ssh-copy-id "$node7"
		
		# Create aliases for mpiexec and python commands on master node
		bash mpi_aliases.sh
		
		# Setup the NFS on master node
		dir=/dev/sda1	# since it should be the only connected drive, probably mounted at sda1
		uuid=`blkid | egrep "$dir" | egrep -o 'UUID=\"[a-z0-9]*(-[a-z0-9]*){4}\"'`	# find NFS UUID
		sudo mkfs.ext4 "$dir"	# format connected drive acting as NFS
		echo "$uuid $nfs_dir ext4 defaults 0 2" >> /etc/fstab	# set NFS drive to automount
		sudo mount -a	# mount the newly-created NFS
		
		# Install NFS server on master node
		sudo apt -y install nfs-kernel-server
		sudo echo "$nfs_dir $master/16(rw,sync,no_root_squash,no_subtree_check)" >> /etc/exports
		sudo exportfs -a	# export NFS share from master node
		
		elif [ "$1" == 'slave' ]
		then
		
		# Each slave node will copy its SSH key to the master node
		ssh-copy-id "$master"
		
		# Install NFS client on all slave nodes
		sudo apt -y install nfs-common
		sudo echo "$master:$nfs_dir $nfs_dir nfs defaults 0 0" >> /etc/fstab	# setup NFS to automount from master node
		sudo mount -a	# mount NFS from master node
	fi
	
	echo
	echo 'Remember to source /etc/environment in order to use $NFS.'
	echo
	
	else
	echo 'Error: You must pass either "slave" or "master" as a parameter.'
fi
