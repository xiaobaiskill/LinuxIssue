# VLAN


# MZ - Comprehensive examples
```
Send a SYN flood attack to another VLAN using VLAN hopping.
This only works if you are connected to the same VLAN which is configured as native VLAN on the trunk.
We assume that the victim VLAN is VLAN 100 and the native VLAN is VLAN 5.
Lets attack every host in VLAN 100 which use an IP prefix of 10.100.100.0/24,
also try out all ports between 1 and 1023 and use a random source IP address.
``
> mausezahn eth0 -c 0 -Q 5,100 -t tcp flags=syn,dp=1-1023 -p 20 -A rand -B 10.100.100.0/24


# IPTables


# refer
### mz
- http://git.bwit.cc

### ovs
- http://docs.openvswitch.org/en/latest/faq/vlan/

### vlan
- https://www.edureka.co/community/39047/how-do-i-set-up-a-minikube-cluster-on-ubuntu?show=39062#a39062
- https://www.cyberciti.biz/tips/howto-configure-linux-virtual-local-area-network-vlan.html
- https://askubuntu.com/questions/709817/ubuntu-15-network-with-bond-vlan-bridge


### iptables
- https://linux.die.net/man/8/iptables
