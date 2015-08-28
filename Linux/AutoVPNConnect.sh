#!/bin/bash

apt-get -y install pptp-linux
echo '# Secrets for authentication using CHAP
# client        server  secret                  IP addresses
vpn-user-name uxvpn vpn-user-password *' > /etc/ppp/chap-secrets

echo 'pty "pptp vpn-server-domain-or-ip --nolaunchpppd"
name vpn-user-name
remotename uxvpn
require-mppe-128
file /etc/ppp/options.pptp
ipparam uxvpn
persist
maxfail 0' > /etc/ppp/peers/uxvpn

echo '#!/bin/bash
if [ "$PPP_IPPARAM" == "uxvpn" ]; then
     route add -net 117.0.0.0/8 dev $PPP_IFACE
     route add 8.8.8.8/32 dev $PPP_IFACE
     echo 'nameserver 8.8.8.8' > /etc/resolv.conf
fi' > /etc/ppp/ip-up.d/vpnroute

chmod +x /etc/ppp/ip-up.d/vpnroute

echo '#!/bin/bash
if [ "$PPP_IPPARAM" == "uxvpn" ]; then
    poff uxvpn
    pon uxvpn
fi' > /etc/ppp/ip-down.d/autoReconnectVPN

chmod +x /etc/ppp/ip-down.d/autoReconnectVPN

echo '#!/bin/bash
sleep 10s
/usr/bin/pon uxvpn' > /root/auto-connect-vpn.sh

chmod +x /root/auto-connect-vpn.sh

echo '#!/bin/sh -e
/root/auto-connect-vpn.sh&
exit 0' > /etc/rc.local

pon uxvpn