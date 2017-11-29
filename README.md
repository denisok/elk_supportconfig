# Import supportconfig to ELK

Creates ELK cluster and watches for logs directory.

So far parses only basic supportconfig, syslog from `messages*.txt` and Ceph logs. For other files more filters needed to be written.
Please check `.conf` files for excluded files and directories.

* setup docker, and docker-compose
* clone this repo, `cd elk_supportconfig`
* `docker-compose up`
* unpack your supportconfig (or supportconfigs if you have cluster) to *logs* directory
* go to Kibana interface in web browser http://your_host:5601
* check Monitoring page to see if logstash completed all the events (Received/Emitted aren't growing)
* go to Dashboard->Ceph general dashboard
* don't forget to change Time Filter in the right corner to something more sane (defaults to 15 Min) - maybe to "Year to date"
* use filters, searches and Time Range to filter and look for you data
* Cltl+C to destroy cluster and `docker-compose rm -v -f` to delete container's data

## Indices, searches, dashboards

You can create your own searches in Discover.
After saving your search/dashboard you can import it from .kibana index and place under kibana directory. You need to delete 

To import index/search/dashboard:

* `curl -XGET 'http://localhost:9200/.kiban*/index-pattern/_search?size=10000&pretty' -o idx-pattern.json`
* `curl -XGET 'http://localhost:9200/.kiban*/search/_search?size=10000&pretty' -o searches.json`
* `curl -XGET 'http://localhost:9200/.kiban*/dashboard/_search?size=10000&pretty' -o dashboard.json`
* get valid json after `"hits" : [`
* you need to remove `"_source": {` and corresponding `}` without removing data inside
* you can use one object per json file in kibana directory

* or create new index pattern `.kibana*` in Kibana (don't use Time Filter)
* go to Discover, choose `.kibana*` pattern, find your object, go to JSON and copy paste it to file
* you need to remove `"_source": {` and corresponding `}` without removing data inside
* you can use one object per json file in kibana directory
 
## Preview

![](https://gist.github.com/denisok/6341c60f704f83f93db47d50b894c9d6/raw/09439b91acb8a15f8d1b578cce243aba7df37754/ceph_general_dashboard.png)
![](https://gist.github.com/denisok/6341c60f704f83f93db47d50b894c9d6/raw/09439b91acb8a15f8d1b578cce243aba7df37754/ceph_dahboard_entry.png)
![](https://gist.github.com/denisok/6341c60f704f83f93db47d50b894c9d6/raw/09439b91acb8a15f8d1b578cce243aba7df37754/ceph_dashboard_logentry.png)

## TODO

* create Beat to import `ceph report` json
* create script or reuse beat to import/export indices, searches, dashboards
* more parsers
* better indices and fields
