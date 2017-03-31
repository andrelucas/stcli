#!/bin/sh

set -e -x -u
go get -v github.com/storageos/go-cli/cmd/storageos
cp ${GOPATH}/bin/storageos ${DAPPER_SOURCE}
