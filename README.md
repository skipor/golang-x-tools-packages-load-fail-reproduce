Repository reproduces `packages.Load` error: `internal error: go list gives conflicting information for package`
which happens, when there is import cycle in code, but there are no 'cycle' import in test files.

```
$ go version
go version go1.16.4 darwin/amd64
$ ./reproduce.sh
+ echo 'Given two packages with import cycle Then packages.Load ok'
Given two packages with import cycle Then packages.Load ok
+ go run .
github.com/skipor/load-fail-reproduce/reproduce/b errors: []
github.com/skipor/load-fail-reproduce/reproduce/a errors: [-: import cycle not allowed: import stack: [github.com/skipor/load-fail-reproduce/reproduce/a github.com/skipor/load-fail-reproduce/reproduce/b github.com/skipor/load-fail-reproduce/reproduce/a] /Users/skipor/dev/src/github.com/skipor/load-fail-reproduce/reproduce/a/a.go:4:2: could not import github.com/skipor/load-fail-reproduce/reproduce/b (import cycle: [github.com/skipor/load-fail-reproduce/reproduce/b github.com/skipor/load-fail-reproduce/reproduce/a])]
+ go list ./...
package github.com/skipor/load-fail-reproduce/reproduce/a
	imports github.com/skipor/load-fail-reproduce/reproduce/b
	imports github.com/skipor/load-fail-reproduce/reproduce/a: import cycle not allowed
+ true
+ echo 'When there is test file WITHOUT import cycle Then packages.Load FAILS'
When there is test file WITHOUT import cycle Then packages.Load FAILS
+ cat
+ cat ./reproduce/a/a_test.go
package a
+ go run .
packages.Load error: internal error: go list gives conflicting information for package github.com/skipor/load-fail-reproduce/reproduce/a [github.com/skipor/load-fail-reproduce/reproduce/a.test]
+ go list ./...
package github.com/skipor/load-fail-reproduce/reproduce/a
	imports github.com/skipor/load-fail-reproduce/reproduce/b
	imports github.com/skipor/load-fail-reproduce/reproduce/a: import cycle not allowed
+ true
+ echo 'When there is test file WITH import cycle Then packages.Load ok'
When there is test file WITH import cycle Then packages.Load ok
+ cat
+ cat ./reproduce/a/a_test.go
package a
import "github.com/skipor/load-fail-reproduce/reproduce/b"
func ImportCycleToo() {b.Bar()}
+ go run .
github.com/skipor/load-fail-reproduce/reproduce/b errors: []
github.com/skipor/load-fail-reproduce/reproduce/a errors: [-: import cycle not allowed: import stack: [github.com/skipor/load-fail-reproduce/reproduce/a github.com/skipor/load-fail-reproduce/reproduce/b github.com/skipor/load-fail-reproduce/reproduce/a] /Users/skipor/dev/src/github.com/skipor/load-fail-reproduce/reproduce/a/a.go:4:2: could not import github.com/skipor/load-fail-reproduce/reproduce/b (import cycle: [github.com/skipor/load-fail-reproduce/reproduce/b github.com/skipor/load-fail-reproduce/reproduce/a])]
github.com/skipor/load-fail-reproduce/reproduce/a [github.com/skipor/load-fail-reproduce/reproduce/a.test] errors: [-: import cycle not allowed in test]
github.com/skipor/load-fail-reproduce/reproduce/a.test errors: []
+ go list ./...
package github.com/skipor/load-fail-reproduce/reproduce/a
	imports github.com/skipor/load-fail-reproduce/reproduce/b
	imports github.com/skipor/load-fail-reproduce/reproduce/a: import cycle not allowed
+ true
+ rm ./reproduce/a/a_test.go

```



