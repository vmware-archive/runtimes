# Golang runtime with go mod dependency management

Implement go runtime using go mod for dependencies.

## ☕ Usage

When used, `go.mod` must declare the module kubeless. Example:

```
module function

go 1.14

require (
	...
)
```

## TODO

- [x] Auto add go.mod when not provided
- [] Official docker images

## Questions

* Should we create a new runtime for go due to breaking changes?
* I used golang as name for the run time, but not sure it`s the best name.
