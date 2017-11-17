# Import supportconfig to ELK

Creates ELK cluster and watches for logs directory.

So far parses only basic supportconfig and syslog from `messages*.txt`. For other files more filters needed to be written.

* setup docker, and docker-compose
* clone this repo, `cd elk_supportconfig`
* create *logs* directory, `mkdir logs`
* `docker-compose up`
* unpack your supportconfig (or supportconfigs if you have cluster) to *logs* directory
* go to kibana interface in web browser http://your_host:5601
* create index `supportconfig-*` without "Time Filter"
* have fun

## Preview

![](https://gist.githubusercontent.com/denisok/6341c60f704f83f93db47d50b894c9d6/raw/9012ee44ffcca79300e556b6b6fde002123e9403/kibana_dashboard.png)

## TODO

* create standard Index and upload it to elasticsearch before kibana starts
* create standard Dashboards and add the to this repo, maybe also upload it to elasticsearch automatically
* add missed filters for suportconfig plugins (Ceph and etc.)
* rework fields and indexes
