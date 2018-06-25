FROM golang:1.10

COPY . /go/src/github.com/sherodtaylor/raft-stash
WORKDIR /go/src/github.com/sherodtaylor/raft-stash

RUN make deps
RUN make build-linux



