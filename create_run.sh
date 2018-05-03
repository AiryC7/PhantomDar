#!/bin/bash

echo ""
echo "PUBG PC IP (192.168.??.??)"
read game_ip

echo ""
echo "Router (gateway) IP (192.168.??.??)"
read router_ip

echo ""
echo "Radar PC IP (Dieser PC) (192.168.??.??)"
read radar_ip

echo ""
echo "interface Name"
ls /sys/class/net
read interface

echo ""
echo "wieviel RAM benutzen? (e.g. 4g or 3g)"
free -h
read ram

cat >run.sh <<EOF
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
if [ -z "\$1" ]
then
  arpspoof -i $interface -t $game_ip $router_ip &> /dev/null &
  arpspoof -i $interface -t $router_ip $game_ip &> /dev/null &
elif [ "\$1" == "--show_arpspoof" ]
then
  arpspoof -i $interface -t $game_ip $router_ip &
  arpspoof -i $interface -t $router_ip $game_ip &
else
  echo 'Unknown argument: '\$1
fi
java -Xmx$ram -jar Gaydar/target/PhantomDar-1.0-jar-with-dependencies.jar $radar_ip PortFilter $game_ip

EOF

chmod +x run.sh
