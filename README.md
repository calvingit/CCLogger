# Logger for iOS

[![Swift Version](https://img.shields.io/badge/Swift-5.0+-orange.svg?style=flat)](https://swift.org)
[![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg?style=flat)](https://www.apple.com/ios/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)

A robust and efficient logging library for iOS applications, designed to provide a reliable and customizable logging solution.

## Features

- **Flexible Logging Levels**: Supports various logging levels (debug, info, warning, error) with customizable log formats.
- **Concurrent Logging**: Ensures thread-safe logging operations, maintaining the correct order of log entries.
- **Automatic Log File Management**: Automatically creates daily log files, with the ability to limit the number of days to retain logs.
- **Configurable Log Output**: Supports logging to both the console and file, with the ability to add custom log output channels.
- **Efficient Performance**: Optimized for performance, ensuring minimal impact on the main application thread.
- **Easy Integration**: Designed as a Swift package, making it easy to integrate into your iOS projects.

## Installation

You can install the Logger using Swift Package Manager. Add the following package to your Xcode project:

```swift
.package(url: "https://github.com/calvingit/CCLogger.git", from: "v1.0.0")
```

## Usage

1. Import the CCLogger Library in your Swift file:

   ```
   import CCLogger
   ```

2. Use the `CCLogger` class to log messages:

   ```
   CCLogger.shared.log("This is a debug message", level: .debug)
   CCLogger.shared.log("This is an info message", level: .info)
   CCLogger.shared.log("This is a warning message", level: .warning)
   CCLogger.shared.log("This is an error message", level: .error)
   ```

3. Customize the logging behavior by adding custom log output channels:

   ```
   let customOutputter = CustomOutputter()
   Logger.shared.addOutputter(customOutputter)
   ```



## Contributing

We welcome contributions to the CCLogger Library! If you find any issues or have suggestions for improvements, please feel free to open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](https://www.perplexity.ai/search/LICENSE).