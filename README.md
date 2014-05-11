# es_console

Console for interacting with elasticsearch, built on top of pry and all its goodies.

### Why

Because I'm tired of typing `curl http://localhost:9200` every single time. This is a weekend project, consider this your 'here be dragons' warning.

### Api

Starting the console:

```
$ bin/es_console
[es]>
```

Setting elasticsearch endpoint:

```
# set url
[es]> url 'http://your_elasticsearch_host:9200'
```

`url` defaults to `http://localhost:9200`.

Getting cluster stats:

```
# get list of indexes with number of docs in each
[es]> stats
> {'myindexa' : 2, 'myindexb' : 0, 'myindexc' : 1}

# count of all documents in cluster
[es]> count
> 10
```

Interacting with indexes:

```
# change into index context
[es]> index 'movies'

# get types of index
[es:'movies']> types
> ['hello']

# check if type exists
[es:'movies']> exists('hello')
> true

# get mapping
[es:'movies']> mapping
> {"adventure":{"properties":{"title":"string"}}}

# delete
[es:'movies']> delete
> true
```

Interacting with types:

```
# change into type context
[es:'movies']> type 'adventure'

# get count
[es:'movies:adventure']> count
> 3

# get document
[es:'movies:adventure']> get 1
>{"_index":"movies","_type":"adventure","_id":"1","_version":1,"exists":true, "_source" : {"title":"Raiders of Last Ark"}}

# get document source
[es:'movies:adventure']> get_source 1
> {"title":"Raiders of Last Ark"}

# check if document exists
[es:'movies:adventure']> exists? 1
> true

# delete document
[es:'movies:adventure']> delete 1
> true

# delete mapping
[es:'movies:adventure']> delete_mapping
> true
```
