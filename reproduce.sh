#!/usr/bin/env bash

set -eu
DIR=$(dirname "$0")
cd "$DIR"

set -x
go run .
go list ./...

