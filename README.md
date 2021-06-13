# clusterphuq
A cluster computer made up of Raspberry Pi 4s.

# Current state of the project
This is project is still very basic at this point. The PDF walkthrough will currently get you far enough along to have a working Raspberry Pi cluster with an NFS (network file system), MPI, and SLURM. I followed along to another tutorial, but have only had time to make it through the first part. The walkthrough will be updated as necessary and will be cited below as well as in the walkthrough. The basic idea will be that one could either follow along step-by-step through the tutorial without any automation (for the full experience), or they can use the automation scripts to (hopefully) simplify the process. There is also a possibilty that a different version using Fedora (or another RPM-based distribution) will also be created, as most of the world's HPC platforms run on RPM-based distributions like RHEL.

# Automation
The Bash script for setting up a static Ethernet IP address is an example of how some parts of this process can be automated. The potential and feasibility for more automation will be examined once I've finished the source tutorial and updated the PDF walkthrough following that.

# Hardware
This will contain a list of the hardware used for the cluster, so that others can have concrete examples of what will work together if they don't feel like looking up specifications themselves.

# Source
Part 1: https://glmdev.medium.com/building-a-raspberry-pi-cluster-784f0df9afbd

Part 2: https://glmdev.medium.com/building-a-raspberry-pi-cluster-aaa8d1f3d2ca

Part 3: https://medium.com/@glmdev/building-a-raspberry-pi-cluster-f5f2446702e8
