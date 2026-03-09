# XLogger

An Enterprise-grade telemetry and logging framework tailored for the Apple ecosystem. 
XLogger combines the native reliability of `OSLog` with powerful network transmission, physical device storage, and rich metadata injection.

## Features

* **Native Integration:** Seamlessly outputs to the macOS Console via Apple's native `OSLog`.
* **Automatic Code Tracing:** Automatically captures the exact file name, function, and line number using Swift compiler macros.
* **Rich Metadata:** Inject custom dictionaries for deep contextual analysis and debugging.
* **Secure Local Storage:** Persists logs to the device's physical SSD in human-readable, ISO8601-timestamped JSON format.
* **Network Broadcasting:** Transmits live telemetry to the companion *XLogger Studio* Mac app via local Bonjour networking.
* **Thread-Safe:** Fully optimized for modern Swift 6 Concurrency (`Sendable`, `Actor`, `@MainActor`).

---

## Installation

Add XLogger to your project using the Swift Package Manager (SPM):
1. In Xcode, go to **File** > **Add Package Dependencies...**
2. Enter the repository URL.
3. Select your desired branch or exact version rule and add it to your target.

---

## Comprehensive Setup Guide

To unlock the full power of XLogger (Network Broadcasting and Physical Storage), you must configure a few settings in your host application.

### Phase 1: Enable Network Broadcasting (iOS 14+ Privacy)
To allow your physical iOS device to send live logs over Wi-Fi to your Mac, you must declare Local Network usage in your app's `Info.plist`:

1. Open your host app's `Info.plist`.
2. Add the **Privacy - Local Network Usage Description** (`NSLocalNetworkUsageDescription`) key. Set the value to a descriptive string, such as: *"XLogger requires local network access to securely transmit telemetry logs to your Mac."*
3. Add the **Bonjour services** (`NSBonjourServices`) key as an Array.
4. Add an item to this array with your exact Bonjour service type (e.g., `_xlogger._tcp`).

### Phase 2: Configure Simulator Storage Routing
When testing on the iOS Simulator, XLogger can magically route your `.json` log files directly into your Mac's Xcode project folder instead of burying them inside the hidden Simulator cache. 

To enable this Developer Experience feature:
1. In Xcode, click your app's name in the top-center toolbar and select **Edit Scheme...**
2. Select **Run** on the left sidebar, then click the **Arguments** tab at the top.
3. Under **Environment Variables**, click the **(+)** button.
4. Set the **Name** to: `XLOGGER_PROJECT_DIR`
5. Set the **Value** to: `$(PROJECT_DIR)`

*Result: A folder named `XLoggerLog` will appear next to your source code on your Mac.*

### Phase 3: Enable Physical Device Storage Access
When your app runs on a physical iPhone in production, XLogger securely saves logs inside the iOS Sandbox (`Documents/XLoggerLog`). To allow users or QA testers to easily extract these logs without a Mac:

1. Open your host app's `Info.plist`.
2. Add the **Application supports iTunes file sharing** (`UIFileSharingEnabled`) key and set it to **YES**.
3. Add the **Supports opening documents in place** (`LSSupportsOpeningDocumentsInPlace`) key and set it to **YES**.

*Result: Users can open the native iOS "Files" app, navigate to "On My iPhone" > "Your App Name", and instantly access or share the `XLoggerLog` folder.*

---

## Quick Start

### Basic Logging
Simply import the framework and use the pre-configured logging levels.

```swift
import XLogger

XLogger.debug("User tapped the login button")
XLogger.info("Application initialized successfully")
XLogger.warning("Memory warning received")
```

## Enterprise Logging (Categories & Metadata)
Inject rich context into your telemetry. XLogger automatically attaches the code-level origin (file and line) behind the scenes.

```swift
XLogger.error(
    "Database connection timeout",
    category: "Network",
    metadata: [
        "userID": "8842A",
        "retryCount": "3",
        "query": "SELECT * FROM users"
    ]
)
```

## Architecture

XLogger operates on a robust, asynchronous multi-dispatch architecture:

* **Console:** Formats and sends the log to the Xcode/macOS Console using `OSLog`.
* **Network:** Broadcasts the payload to the companion app for real-time remote monitoring.
* **Storage:** Automatically isolates and writes JSON logs to the device SSD using a thread-safe Swift 6 `Actor`.
