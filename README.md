# raspberry_pi_cluster
A cluster computer made up of Raspberry Pi 4s.

# Current state of the project
This project is still very basic at this point. The PDF walkthrough will currently get you far enough along to have a working Raspberry Pi cluster with an NFS (network file system), MPI, and SLURM. I followed along to another tutorial, but have only had time to make it through the first part. The walkthrough will be updated as necessary and will be cited below as well as in the walkthrough. This is intended to be an automated version of the primary tutorial referenced below. There is also a possibilty that a different version using Fedora (or another RPM-based distribution) will also be created, as most of the world's HPC platforms run on RPM-based distributions like RHEL.

# Automation
There are now Bash scripts for automating much of the setup process for building a cluster. Anyone that wants to follow along step-by-step without any automation can go to the links below or in the PDF walkthrough. The primary tutorial is a great tutorial, and that's why I mostly used it as reference, but if this process is done more than once after the learning curve is surpassed, doing everything step-by-step would get old fast. These Bash scripts are intended to give you the same result but faster once you know what you're doing. Because I also (currently) have a life and a job, these scripts have not yet been properly tested to ensure they work as intended, although they have been scrutinized extensively. Once Debian Bullseye becomes stable and subsequently Raspbian Bullseye releases, that will likely provide a perfect opportunity to test them.

# Assumptions
This walkthrough assumes the user has more than a beginner's experience using Linux, specifically Debian-based distributions, as well as Raspberry Pis using Raspbian (another Debian derivative), specifically Raspberry Pi 4s and Raspbian Buster. It is also assumed that the user's host OS from which they will access the cluster is Debian-based.

# Hardware
This will contain a list of the hardware used for the cluster, so that others can have concrete examples of what will work together if they don't feel like looking up specifications themselves.

# Sources
Primary
Part 1: https://glmdev.medium.com/building-a-raspberry-pi-cluster-784f0df9afbd

Part 2: https://glmdev.medium.com/building-a-raspberry-pi-cluster-aaa8d1f3d2ca

Part 3: https://glmdev.medium.com/building-a-raspberry-pi-cluster-f5f2446702e8

Secondary
https://magpi.raspberrypi.org/articles/build-a-raspberry-pi-cluster-computer
