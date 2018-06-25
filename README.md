# Raft Stash

A key value store based on hashicorp raft implementation backed with boltdb. Replicates to multiple nodes and can retrieve data from any node. https://raft.github.io/

## Running multiple nodes

1. clone repo `git clone https://github.com/sherodtaylor/raft-stash`
2. build using docker-compose `docker-compose build`
3. run with docker-compose `docker-compose up`
4. cd into out/ directory `cd out/`
5. run commands for raftstash-cli


## Raft Stash CLI
caveat cannot propose changes from any node only leader can update the.

```
$ raftstash-cli --help
Usage: -host [get|set] [key] [value (optional)]
  -host string
        http server for api (default "127.0.0.1:11000")
```

examples
```
$ ./raftstash-cli set hello sherod
``

```
$ ./raftstash-cli get hello
{"hello": "sherod"}
``

## Build locally
```
$ make build
$ make build-linux ## for linux
```


