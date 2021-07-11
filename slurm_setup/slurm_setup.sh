#!/bin/bash

if [ "$1" == 'master' -o "$1" == 'slave' ]
	then
	
	if [ "$1" == 'master' ]
		then
		bash master_slurm_setup.sh
		
		elif [ "$1" == 'slave' ] 
		then
		bash slave_slurm_setup.sh
			
	else
	echo 'Error: You must pass either "slave" or "master" as a parameter.'
fi
