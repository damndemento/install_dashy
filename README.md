# Script to install Dashy
Bash script to install dashy inside a debian 11 container using lxc or proxmox!

To install Dashy on Debian 11 (Bullseye) using this script please use the following steps:

- create a Debian 11 container with at least 1024Mb RAM and 2 CPUs.
- if curl is not installed do it by executing:<br>
```apt update && apt install -y curl```
- download this script using curl:<br>
```curl https://raw.githubusercontent.com/damndemento/install_dashy/main/install_dashy.sh > install_dashy.sh```
- make the script executable:<br>
```chmod +x install_dashy.sh```
- execute the script:<br>
```bash install_dashy.sh```

After the script has finished without errors you should be able to configure and use Dashy
by opening<br>
```http://<container-ip-address>:4000``` in your browser (e.g. 192.168.0.1:4000).
