#!/bin/bash
DOMAIN="$1"
(cat /etc/pf.conf && echo "throtlenet-anchor \"mop\"" && echo "anchor \"mop\"") | sudo pfctl -f -

echo "throttlenet in quick proto tcp from any to $DOMAIN port any pipe 1" | sudo pfctl -a mop -f -

# TO ENABLE THROTTLE
# sudo dnctl pipe 1 config bw 1Mbit/s

# TO RESET
# sudo dnctl flush
# sudo pfctl -f /etc/pf.conf
