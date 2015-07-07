#!/bin/bash 

curl 'localhost:9200/_cat/indices?v' > /tmp/indices-logstash.txt
awk -F " " '{print $2}' /tmp/index-logstash.txt > /tmp/clean-index.txt


while read ligne
do
    if $ligne != kibana-int
    then
        curl -XDELETE "http://localhost:9200/$ligne"
        echo "clean $ligne"
    fi
done < /tmp/clean-index.txt

