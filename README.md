# LoggerHelper

A simple Swift logging library for macOS apps. Log messages at different levels (info, warning, debug, error), control logging globally, and customize subsystem and category for each message.

## Features

- Four log levels: **info**, **warning**, **debug**, **error**
- Enable or disable all logging with one flag
- Default subsystem is your app’s bundle identifier (overrideable)
- Default category is "General" (overrideable)
- Each log entry includes file name, line number, and function name

## Requirements

- macOS 10.15 or later
- Swift 5.5 or later

## Installation

### Swift Package Manager

1. In Xcode, choose **File ▸ Add Packages…**
2. Enter the URL of this repository:
   ```
   https://github.com/Krusty84/LoggerHelper.git
   ```
3. Select the version (for example, Up to Next Major 1.0.0) and add it to your app target.

## Usage

1. **Enable logging** early in your app:

```swift
import SwiftUI
import LoggerHelper

struct ContentView: View {
    @State private var isLoggingEnabled: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Hello, world!")
                .font(.title)
            
            // Toggle to enable/disable logging
            Toggle("Enable Logging", isOn: $isLoggingEnabled)
                .padding(.horizontal)
                .onChange(of: isLoggingEnabled) { newValue in
                    LoggerHelper.loggingEnabled = newValue
                }
            
            // Buttons for each log level
            VStack(spacing: 10) {
                Button("Info Log") {
                    LoggerHelper.info("This is an info message")
                }
                Button("Warning Log") {
                    LoggerHelper.warning("This is a warning message")
                }
                Button("Debug Log") {
                    LoggerHelper.debug("This is a debug message")
                }
                Button("Error Log") {
                    LoggerHelper.error("This is an error message")
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .onAppear {
            // initialize the helper with the same flag
            LoggerHelper.loggingEnabled = isLoggingEnabled
        }
    }
}
```

2. **Log with defaults**:

   ```swift
   LoggerHelper.info("Hello, world!")
   ```
   - Uses `Bundle.main.bundleIdentifier` as subsystem
   - Uses `"General"` as category

3. **Log with custom subsystem or category**:

   ```swift
   LoggerHelper.debug(
     "User tapped button",
     subsystem: "com.mycompany.mytool",
     category: "UI"
   )
   ```

4. **Other levels**:

   ```swift
   LoggerHelper.warning("Low disk space")
   LoggerHelper.error("Failed to load data")
   ```
