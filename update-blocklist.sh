#!/bin/bash

# Working Directory, for dumpfile
DMPDIR=/opt/hosts
BACKPUDIR=$DMPDIR/backup

# Where shall it be saved, usually it's used for squidguard, can be used 1by1 for squid ACL also
PATH2=/var/lib/squidguard/db/BL/BadSites
FILE2=domains

# Source Area
FILE1=$DMPDIR/tmp.file
FDATE=$(date '+%Y-%m-%d')

# Create always required paths if they don't exist
mkdir -p "$PATH2" "$DMPDIR" "$BACKPUDIR" >/dev/null 2>&1

# Backup existing files
if [ -f "$PATH2/$FILE2" ]; then
  xz --threads=0 --best < "$PATH2/$FILE2" > "$BACKPUDIR/backup.domains.$FDATE.xz"
fi

if [ -f "$FILE1" ]; then
  xz --threads=0 --best < "$FILE1" > "$BACKPUDIR/backup.TMPFILE.$FDATE.xz"
  rm "$FILE1"
fi

# Download hosts
urls=(
  "https://raw.githubusercontent.com/StevenBlack/hosts/master/data/StevenBlack/hosts"
  "https://raw.githubusercontent.com/brijrajparmar27/host-sources/master/Porn/hosts"
  "https://raw.githubusercontent.com/Sinfonietta/hostfiles/master/pornography-hosts"
  "https://raw.githubusercontent.com/StevenBlack/hosts/master/extensions/porn/clefspeare13/hosts"
  "https://raw.githubusercontent.com/tiuxo/hosts/master/porn"
  "https://raw.githubusercontent.com/AdAway/adaway.github.io/master/hosts.txt"
  "https://raw.githubusercontent.com/StevenBlack/hosts/master/data/StevenBlack/hosts"
  "https://raw.githubusercontent.com/djdomi/squidguard-blocklist/main/files/domains"
)

for url in "${urls[@]}"; do
  curl -fs "$url" >>"$FILE1"
done


mkdir -p $PATH2


#We have here two options - one, that just remove ips
cat $FILE1 | sed '/#/d; s/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\} //g; /^$/d' | sort --unique  > $PATH2/$FILE2

#the second that has still some issues like .de.vu where i need to fix it in the future
#cat $FILE1 | sed '/#/d; s/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\} //g; /^$/d; s/^[^.]*\.//g' | awk -F'.' '{if (NF>2) print $(NF-1)"."$NF; else print $0}' | sort --unique > $PATH2/$FILE2




##old tries, saving for future (ideas) :D or to see how i did it, while trying to impve it :D
##sed "/#/d" | sed '/^$/d' | sed -e 's/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}//g' 		> $FILE1
