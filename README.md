# AppIconGenerator

Generate [1024x1024 app icons](https://developer.apple.com/documentation/xcode/configuring-your-app-icon) for your Xcode projects using a json config file.

Intended for use when scaffolding demo/exaple apps using [Tuist](https://tuist.dev/) or any other Xcode project generation tools.

## Running

Assuming a config file at `appicon.json` and an output file of `appicon.png` run:

```
swift run IconGenerator
```

Run with `--help` to configure.

## Configuration

The JSON appicon spec is encoded at [Sources/IconGenerator/Configuration.swift](./Sources/IconGenerator/Configuration.swift). Checkout out our [example appicon.json](./appicon.json) to see the basics.
