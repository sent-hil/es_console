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

Getting all indexes info:

```
# get list of indexes with number of docs in each
[es]> list
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
# create template
[es] > create_template('mytemplate', {template: 'mytemplate*', mappings: { type1: {type: 'string'}}})
> true

# get template
[es] > get_template 'mytemplate'
> {"mytemplate":{"order":0,"template":"mytemplate*","settings":{},"mappings":{"type1":{"type":"string"}}}}

# delete template
[es] > delete_template 'mytemplate'
true
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
