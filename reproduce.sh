#!/usr/bin/env bash

set -eu
DIR=$(dirname "$0")
cd "$DIR"

set -x
echo "Given two packages with import cycle Then packages.Load ok"
go run .
go list ./... || true

echo "When there is test file WITHOUT import cycle Then packages.Load FAILS"
cat <<EOF >./reproduce/a/a_test.go
package a
EOF
cat ./reproduce/a/a_test.go

go run .
go list ./... || true

echo "When there is test file WITH import cycle Then packages.Load ok"
cat <<EOF >./reproduce/a/a_test.go
package a
import "github.com/skipor/load-fail-reproduce/reproduce/b"
func ImportCycleToo() {b.Bar()}
EOF
cat ./reproduce/a/a_test.go

go run .
go list ./... || true

rm ./reproduce/a/a_test.go
