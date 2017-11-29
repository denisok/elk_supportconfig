#!/bin/bash

set -euo pipefail

es_url=http://elastic:${ELASTIC_PASSWORD}@elasticsearch:9200

# Wait for Elasticsearch to start up before doing anything.
until curl -s $es_url -o /dev/null; do
	sleep 1
done

# Wait for kibana
until curl -XGET http://kibana:5601/status -I -o /dev/null; do
	sleep 1
done

# Set the default index for kibana.
until curl -s -H 'Content-Type:application/json' \
	-XPOST $es_url/.kibana/config/${TAG}/_update \
	-d "{\"doc\": {\"defaultIndex\": \"cephlog-index\"}}"
do
	sleep 2
	echo Retrying...
done

