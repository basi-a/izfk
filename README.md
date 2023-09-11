# izfk
Install ZeroTier for Kali, Fixed the OpenSSL 1.1 dependency issue
# Why write this script?
In order for her to join my LAN, so that she can connect to my development board, so that she can easily set up the range for penetration testing
# So how to use it?
## Change the value of this variable in the script
```bash
...
NetworkID="<Your Zerotier's NetworkID>"
...
```
## Run the script
```bash
./zerotier-one-linux-install.sh
```
## Go to Zerotier to authorize to join the network
# Execute two commands to exit/join the network
```bash
# Only the first time you need it, or just restart it then don't need to do it
source $HOME/.zshrc
# Leave the ZeroTier network and join the ZeroTier network
zerotier_leave
zerotier_join
```
