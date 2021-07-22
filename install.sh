#!/usr/bin/env bash

cd "$( dirname "${BASH_SOURCE[0]}" )"

echo "------------------------------------"
echo "       installing firmadyne         "
echo "------------------------------------"

echo "->  Install FIRMAE"
git clone --recursive https://github.com/pr0v3rbs/FirmAE && cd ./FirmAE
./download.sh
./install.sh
./init.sh
FIRMAE_PATH=$(pwd)


echo "-> add necessary sudo rights"
# Insert additional changes to the sudoers file by applying the syntax used below
CURUSER=$(whoami 2>&1)
printf "$CURUSER\tALL=NOPASSWD: /usr/bin/nmap \n\
$CURUSER\tALL=NOPASSWD: /usr/local/bin/nmap \n\
$CURUSER\tALL=NOPASSWD: /usr/sbin/tunctl \n\
$CURUSER\tALL=NOPASSWD: /sbin/ip \n\
$CURUSER\tALL=NOPASSWD: /bin/ip \n\
$CURUSER\tALL=NOPASSWD: $FIRMAE_PATH/run.sh \n" > /tmp/firmadyne_overrides
sudo chown root:root /tmp/firmadyne_overrides
sudo mv /tmp/firmadyne_overrides /etc/sudoers.d/firmadyne_overrides

exit 0
