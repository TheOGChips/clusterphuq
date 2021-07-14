# raspberry_pi_cluster
A cluster computer made up of Raspberry Pi 4s.

# Current state of the project
This project is still very basic at this point. The PDF walkthrough will currently get you far enough along to have a working Raspberry Pi cluster with an NFS (network file system), MPI, and SLURM. I followed along to another tutorial, but have only had time to make it through the first part. The walkthrough will be updated as necessary and will be cited below as well as in the walkthrough. This is intended to be an automated version of the primary tutorial referenced below. There is also a possibilty that a different version using Fedora (or another RPM-based distribution) will also be created, as most of the world's HPC platforms run on RPM-based distributions like RHEL.

# Automation
There are now Bash scripts for automating much of the setup process for building a cluster. Anyone that wants to follow along step-by-step without any automation can go to the links below or in the PDF walkthrough. The primary tutorial is a great tutorial, and that's why I mostly used it as reference, but if this process is done more than once after the learning curve is surpassed, doing everything step-by-step would get old fast. These Bash scripts are intended to give you the same result but faster once you know what you're doing. Because I also (currently) have a life and a job, these scripts have not yet been properly tested to ensure they work as intended, although they have been scrutinized extensively. Once Debian Bullseye becomes stable and subsequently Raspbian Bullseye releases, that will likely provide a perfect opportunity to test them.

# Assumptions
This walkthrough assumes the user has more than a beginner's experience using Linux, specifically Debian-based distributions, as well as Raspberry Pis using Raspbian (another Debian derivative), specifically Raspberry Pi 4s and Raspbian Buster. It is also assumed that the user's host OS from which they will access the cluster is Debian-based.

# Hardware
Raspberry Pi and heatsink combos purchased from Vilros. All other hardware purchased through Amazon. A better source for Ethernet cables is also provided, and had I known about it at the time, I would've ordered from there instead, if for no other reason than having the capability to purchase cables individually. Regardless of that, all of this hardware has so far performed really well.

-1x C4Labs Cloudlet CASE: Cluster Case for Raspberry Pi and Other Single Board Computers-Black Lime
https://www.amazon.com/gp/product/B0844YSJWB/ref=ppx_yo_dt_b_asin_title_o07_s00?ie=UTF8&psc=1

-1x Anker 60W 10-Port USB Wall Charger, PowerPort 10 for iPhone Xs/XS Max/XR/X/8/7/6s/Plus, iPad Pro/Air 2/Mini, Galaxy S9/S8/S7/Edge/Plus, Note 8/7, LG, Nexus, HTC and More
https://www.amazon.com/gp/product/B00YRYS4T4/ref=ppx_yo_dt_b_asin_title_o08_s01?ie=UTF8&psc=1

-8x UGREEN USB C Cable Right Angle 90 Degree USB A to Type C Fast Charger Compatible with Samsung Galaxy S20 S10 S9 S8 Plus Note 9 8, LG G8 G7 V40 V20 V30 G6 G5, Nintendo Switch, GoPro Hero 7 6 5 (3FT)
https://www.amazon.com/gp/product/B07G29Y1JK/ref=ppx_yo_dt_b_asin_title_o08_s01?ie=UTF8&psc=1

-1x TP-Link 16 Port 10/100Mbps Fast Ethernet Switch | Desktop or Wall-Mounting | Plastic Case Ethernet Splitter | Unshielded Network Switch | Plug and Play | Fanless Quiet | Unmanaged (TL-SF1016D)
https://www.amazon.com/gp/product/B003CFATTM/ref=ppx_yo_dt_b_asin_title_o08_s00?ie=UTF8&psc=1

-2x Cat6 Ethernet Cable (1.5 Feet) LAN, UTP (18 inch) Cat 6 RJ45, Network, Patch, Internet Cable - 6 Pack (1.5 ft)
https://www.amazon.com/gp/product/B0721RFHT8/ref=ppx_yo_dt_b_asin_title_o08_s01?ie=UTF8&psc=1
Note: Probably a better source, if for no other reason than cables can be purchased individually. Also recommended by an HPC admin from my university: https://www.monoprice.com/category/cables/networking-patch-cables/cat6-ethernet-cables?&menuDisStr=cat6%20ethernet%20cables&v_master_Length_uFilter=0.5ft

-4x SanDisk 32GB 2-Pack Ultra microSDHC UHS-I Memory Card (2x32GB) - SDSQUAR-032G-GN6MT
https://www.amazon.com/gp/product/B087JCL881/ref=ppx_yo_dt_b_asin_title_o06_s00?ie=UTF8&psc=1

-1x VELCRO Brand ONE WRAP Thin Ties | Strong & Reusable | Perfect for Fastening Wires & Organizing Cords | Black & Gray, 8 x 1/2-Inch | 25 Black + 25 Gray Ties
https://www.amazon.com/gp/product/B000F5K82A/ref=ppx_yo_dt_b_asin_title_o02_s00?ie=UTF8&psc=1

-1x VELCRO Brand Extreme Tape Strips | 4 x 2 Inch 2 Sets | Holds 15 lbs |Heavy Duty Black with Stick on Adhesive | Strong Holding Power for Outdoor Use
https://www.amazon.com/gp/product/B00JJPPNHM/ref=ppx_yo_dt_b_asin_title_o02_s00?ie=UTF8&psc=1

-8x Raspberry 4 Model B 2GB with Vilros Heatsink Set of 4
https://vilros.com/products/raspberry-pi-4-model-b-vilros-heatsink-set-of-4

# Sources
Primary
Part 1: https://glmdev.medium.com/building-a-raspberry-pi-cluster-784f0df9afbd

Part 2: https://glmdev.medium.com/building-a-raspberry-pi-cluster-aaa8d1f3d2ca

Part 3: https://glmdev.medium.com/building-a-raspberry-pi-cluster-f5f2446702e8

Secondary
https://magpi.raspberrypi.org/articles/build-a-raspberry-pi-cluster-computer
