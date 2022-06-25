#!/bin/bash
newver=`curl -s https://ftp.mozilla.org/pub/firefox/releases/ | grep "<td><a href=" |cut -d '/' -f 5 | sort -n | tail -n 1`
firelocation=`which firefox`
curver=`$firelocation -v | cut -d " " -f 3`

if [ $newver != $curver ]
then
        echo "The current firefox version: $curver"
        read -p "Do you want to upgrade to $newver the please close firefox (Y/N): " ans
        if [ $ans == "Y" ]
        then
		wget -O /tmp/firefox.tar.bz2 https://ftp.mozilla.org/pub/firefox/releases/$newver/linux-x86_64/en-US/firefox-$newver.tar.bz2
		pidof firefox | xargs kill -9
                tar -xvf /tmp/firefox.tar.bz2 -C /opt/
		rm $firelocation
		ln -s /opt/firefox/firefox $firelocation
        else
                exit 0
        fi
else
        echo "Current firefox is updated"
fi

