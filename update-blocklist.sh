#created by https://github.com/djdomi/squidguard-blocklist with GPL v3
#Working Directory
DMPDIR=/opt/hosts/
mkdir -p $DMPDIR
#Where shall it be saved
PATH2=/var/lib/squidguard/db/BL/VeryBadSites/
FILE2=domains



#Requires HOSTFORMAT
FILE1=$DMPDIR/tmp.file
### Working AREA - Read Source for Credits as i dont be the original author of the source files but of the converter code ;-)

#Source Area - first line, overwrite the file, the others EXTEND it
curl -sf https://raw.githubusercontent.com/StevenBlack/hosts/master/data/StevenBlack/hosts 				       > $FILE1
curl -sf https://raw.githubusercontent.com/brijrajparmar27/host-sources/master/Porn/hosts 				      >> $FILE1
curl -sf https://raw.githubusercontent.com/Sinfonietta/hostfiles/master/pornography-hosts 				      >> $FILE1
curl -sf https://raw.githubusercontent.com/StevenBlack/hosts/master/extensions/porn/clefspeare13/hosts 	>> $FILE1
curl -sf https://raw.githubusercontent.com/tiuxo/hosts/master/porn 										                  >> $FILE1
curl -sf https://raw.githubusercontent.com/AdAway/adaway.github.io/master/hosts.txt 					          >> $FILE1
curl -sf https://raw.githubusercontent.com/StevenBlack/hosts/master/data/StevenBlack/hosts 				      >> $FILE1
curl -sf "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext" >> $FILE1 
curl -sf "https://raw.githubusercontent.com/djdomi/squidguard-blocklist/main/files/domains"             >> $FILE1

#REMKARS !! #REMKARS !! #REMKARS !! #REMKARS !! #REMKARS !! #REMKARS !! #REMKARS !! #REMKARS !! #REMKARS !! #REMKARS !! #REMKARS !! 
#this script can easy extended like above, 
# 1.2.3.4 foo.bar.local -> its working !!!
# foo.bar 1.2.3.4		-> NOT working!!!
# 




mkdir -p $PATH2
cat $FILE1 | sed '/#/d; s/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\} //g; /^$/d' | sort --unique  > $PATH2/$FILE2



##old tries, saving for future (ideas) :D or to see how i did it, while trying to impve it :D
##sed "/#/d" | sed '/^$/d' | sed -e 's/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}//g' 		> $FILE1
