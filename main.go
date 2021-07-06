package main

import (
	"fmt"

	"golang.org/x/tools/go/packages"
)

func main() {
	pkgs, err := packages.Load(&packages.Config{
		Mode:       packages.NeedName | packages.NeedSyntax | packages.NeedTypes | packages.NeedTypesInfo,
		Tests:      true,
	}, "./reproduce/...")
	if err != nil {
		fmt.Printf("packages.Load error: %s\n", err)
	}
	for _, pkg := range pkgs {
		fmt.Printf("%s errors: %s\n", pkg.ID, pkg.Errors)
	}
}
