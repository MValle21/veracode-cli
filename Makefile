#!/bin/bash

VERSION=$(cat version)

run:
	go run -ldflags="-X main.Version=$VERSION" ./...

clean:
	rm -rf ../../bin/*
	go clean

format:
	go fmt

build: format
	which gox > /dev/null || go get github.com/mitchellh/gox
	gox -ldflags="-X main.Version=$VERSION" -output="../../bin/veracode-cli_{{.OS}}_{{.Arch}}" ./...

version:
	echo $VERSION

.PHONY: run clean format build version