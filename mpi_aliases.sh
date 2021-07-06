#!/bin/bash
# This file creates aliases for mpiexec and mpi4py commands to make their use easier by being less verbose

BASH_ALIASES=~/.bash_aliases

# Ethernet IP addresses for each Raspberry Pi
master=10.10.10.0
node1=10.10.10.1
node2=10.10.10.2
node3=10.10.10.3
node4=10.10.10.4
node5=10.10.10.5
node6=10.10.10.6
node7=10.10.10.7

echo "alias mpiexec='mpiexec --mca btl_tcp_if_include eth0'" >> "$BASH_ALIASES"
echo "alias mpiexec-n2='mpiexec -n 2 --host $master,$node1'" >> "$BASH_ALIASES"
echo "alias mpiexec-n3='mpiexec -n 3 --host $master,$node1,$node2'" >> "$BASH_ALIASES"
echo "alias mpiexec-n4='mpiexec -n 4 --host $master,$node1,$node2,$node3'" >> "$BASH_ALIASES"
echo "alias mpiexec-n5='mpiexec -n 5 --host $master,$node1,$node2,$node3,$node4'" >> "$BASH_ALIASES"
echo "alias mpiexec-n6='mpiexec -n 6 --host $master,$node1,$node2,$node3,$node4,$node5'" >> "$BASH_ALIASES"
echo "alias mpiexec-n7='mpiexec -n 7 --host $master,$node1,$node2,$node3,$node4,$node5,$node6'" >> "$BASH_ALIASES"
echo "alias mpiexec-n8='mpiexec -n 8 --host $master,$node1,$node2,$node3,$node4,$node5,$node6,$node7'" >> "$BASH_ALIASES"
echo "alias mpiexec-n2-py='mpiexec-n2 python -m mpi4py'" >> "$BASH_ALIASES"
echo "alias mpiexec-n3-py='mpiexec-n3 python -m mpi4py'" >> "$BASH_ALIASES"
echo "alias mpiexec-n4-py='mpiexec-n4 python -m mpi4py'" >> "$BASH_ALIASES"
echo "alias mpiexec-n5-py='mpiexec-n5 python -m mpi4py'" >> "$BASH_ALIASES"
echo "alias mpiexec-n6-py='mpiexec-n6 python -m mpi4py'" >> "$BASH_ALIASES"
echo "alias mpiexec-n7-py='mpiexec-n7 python -m mpi4py'" >> "$BASH_ALIASES"
echo "alias mpiexec-n8-py='mpiexec-n8 python -m mpi4py'" >> "$BASH_ALIASES"
echo "alias mpiexec-n2-py3='mpiexec-n2 python3 -m mpi4py'" >> "$BASH_ALIASES"
echo "alias mpiexec-n3-py3='mpiexec-n3 python3 -m mpi4py'" >> "$BASH_ALIASES"
echo "alias mpiexec-n4-py3='mpiexec-n4 python3 -m mpi4py'" >> "$BASH_ALIASES"
echo "alias mpiexec-n5-py3='mpiexec-n5 python3 -m mpi4py'" >> "$BASH_ALIASES"
echo "alias mpiexec-n6-py3='mpiexec-n6 python3 -m mpi4py'" >> "$BASH_ALIASES"
echo "alias mpiexec-n7-py3='mpiexec-n7 python3 -m mpi4py'" >> "$BASH_ALIASES"
echo "alias mpiexec-n8-py3='mpiexec-n8 python3 -m mpi4py'" >> "$BASH_ALIASES"
