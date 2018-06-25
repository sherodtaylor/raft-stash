# Go parameters
GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
GOINSTALL=$(GOCMD) install
BINARY_NAME=raftstash
BINARY_CLI=$(BINARY_NAME)-cli
BINARY_UNIX=$(BINARY_NAME)-unix
BINARY_UNIX_CLI=$(BINARY_CLI)-unix
BINARY_PATH=out/
BINARY_PATH_TO_FILE=$(BINARY_PATH)$(BINARY_NAME)
BINARY_PATH_TO_FILE_CLI=$(BINARY_PATH)$(BINARY_CLI)
BINARY_PATH_TO_UNIX=$(BINARY_PATH)$(BINARY_UNIX)
BINARY_PATH_TO_UNIX_CLI=$(BINARY_PATH)$(BINARY_UNIX_CLI)
all: test build
build: deps
		$(GOBUILD) -o $(BINARY_PATH_TO_FILE) -v ./cmd/node/main.go
		$(GOBUILD) -o $(BINARY_PATH_TO_FILE_CLI) -v ./cmd/cli/main.go
test:
		$(GOTEST) -v ./...
clean:
		$(GOCLEAN)
		rm -f $(BINARY_PATH_TO_FILE)
		rm -f $(BINARY_PATH_TO_FILE_CLI)
run:
		$(GOBUILD) -o $(BINARY_PATH_TO_UNIX) -v ./cmd/node/main.go
		./$(BINARY_PATH_TO_FILE)
deps:
		$(GOGET) github.com/hashicorp/raft
		$(GOGET) github.com/hashicorp/raft-boltdb
		$(GOGET) github.com/avast/retry-go

# Cross compilation
build-linux:
		CGO_ENABLED=0 GOOS=linux GOARCH=amd64 $(GOBUILD) -o $(BINARY_PATH_TO_UNIX) -v ./cmd/node/main.go
		CGO_ENABLED=0 GOOS=linux GOARCH=amd64 $(GOBUILD) -o $(BINARY_PATH_TO_UNIX_CLI) -v ./cmd/cli/main.go
