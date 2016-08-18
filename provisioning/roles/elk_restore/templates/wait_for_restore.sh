#!/bin/bash

index="$1"
echo "waiting for  $index to be restored"
sleep 5

result=`curl -s -XGET http://localhost:9200/$index/_recovery?pretty  | grep "%"  | grep -v 100 | wc -l`
progress='curl -s -XGET http://localhost:9200/$index/_recovery?pretty  | grep "%"'
eval $progress
while [ "$result" -ne "0" ]
do
   result=`curl -s -XGET http://localhost:9200/$index/_recovery?pretty  | grep "%"  | grep -v 100 | wc -l`
   eval $progress
   sleep 5
done
echo "restored"
