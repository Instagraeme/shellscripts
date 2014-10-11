#!/bin/sh

KEY="$HOME/.ssh/id_rsa.pub"
SERVERS="graeme@radioserver.local graeme@cctv.local graeme@webserver.local
graeme@mediaencoder.local fisher hebrides"

#SERVERS="graeme@cctv.local graeme@volumio.local graeme@webserver.local fisher hebrides"

if [ ! -f $KEY ];then
   echo "private key not found at $KEY"
   echo "* please create it with \"ssh-keygen -t rsa -b 4096\" *"
   exit 1
fi
for SERVER in $SERVERS
do
   echo "Putting your key on $SERVER... "
   ssh -o ConnectTimeout=15 -q $SERVER "umask 0077; mkdir -p ~/.ssh ; echo "`cat $KEY`" > ~/.ssh/authorized_keys"
   echo "done!"
done
