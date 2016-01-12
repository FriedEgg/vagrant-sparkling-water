#!/bin/bash
source "/vagrant/install/main.sh"

function disableFirewall {
echo
echo
info "--- Disabling firewall"
info "---------------------------------------------------------------------"

info "Modifying iptables"

#[Debian Linux Stop Iptables Firewall](http://www.cyberciti.biz/faq/debian-iptables-stop/)
iptables-save > /root/working.iptables.rules

iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
}

disableFirewall