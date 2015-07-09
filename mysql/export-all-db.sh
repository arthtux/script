#!/usr/bin/bash

mysql -e "show databases;" > /tmp/databases.txt


while read ligne
do
    if $ligne != "mysql"
    then
        mysqldump $ligne > $ligne.sql
        echo "dump $ligne"
    fi
done < /tmp/databases.txt

tar cvzf dump-sql.tar.gz 

while read ligne
do 
    if $ligne != "mysql"
        rm -rf $ligne.sql
    fi
done < /tmp/databases.txt


