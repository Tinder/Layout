# Contributing to Layout

- [Open Package in Xcode](#open-package-in-xcode)
- [Static Analysis](#static-analysis)
- [Testing](#testing)

## Open Package in Xcode

> The file header comment template will also be installed.

```
make open
```

## Static Analysis

> SwiftLint violations are visible in Xcode as well.

To run SwiftLint from the command line:

```
make lint
```

To run analysis rules:

```
make analyze
```

## Testing

To re-record all existing snapshot references, delete all using the following command and then run the tests.

```
make delete-snapshots
```
