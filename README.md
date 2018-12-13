# path

A library for constructing well-typed paths in Idris.

Currently undocumented and incomplete.

## Building

### [elba](https://github.com/elba/elba)

Add this line to the `[dependencies]` section of your project's `elba.toml`:

```toml
"elba/path" = { git = "https://github.com/elba/path" }
```

### idris' built-in ipkg

Clone the repository and install using the included ipkg:

```shell
$ git clone https://github.com/elba/path && cd path
$ idris --install path.ipkg
```