# Contributing to Layout

- [Dependencies](#dependencies)
- [Open Package in Xcode](#open-package-in-xcode)
- [Static Analysis](#static-analysis)
- [Testing](#testing)

## Dependencies

Follow the [Swift Package Resources installation instructions](https://github.com/TinderApp/Swift-Package-Resources) to install tooling dependencies.

## Open Package in Xcode

> The file header comment template will also be installed.

```
make open
```

## Static Analysis

> SwiftLint violations are visible in Xcode as well.

Package dependencies must be resolved to download the SwiftLint binary.

```
swift package resolve
```

To run SwiftLint from the command line:

```
make lint
```

To run analysis rules:

```
make analyze
```

To enable new rules whenever SwiftLint is upgraded to a new version:

```
make rules
```

## Testing

To re-record all existing snapshot references, delete all using the following command and then run the tests.

```
make delete-snapshots
```
