# Setting up OracleSharedFramework in Xcode

## Steps to add the shared framework to your Xcode project:

### 1. Add Framework Target
1. Open your Xcode project
2. Select the project root in the navigator
3. Click the "+" button at the bottom of the targets list
4. Choose "Framework" under iOS
5. Name it "OracleSharedFramework"
6. Set the bundle identifier to "com.oracleofnonsense.OracleSharedFramework"
7. Set the deployment target to match your app (iOS 14.0+)

### 2. Add Source Files to Framework
1. Right-click on the OracleSharedFramework target in the navigator
2. Choose "Add Files to 'Oracle Of Nonsense iOS'"
3. Navigate to the OracleSharedFramework folder
4. Select all the Swift files and the CSV file:
   - PhraseTemplate.swift
   - PhraseGenerator.swift
   - SharedModels.swift
   - CSVManager.swift
   - SharedFrameworkTests.swift
   - master.csv
5. Make sure "OracleSharedFramework" target is checked
6. Click "Add"

### 3. Add Framework to App Targets
1. Select the "Oracle Of Nonsense iOS" target
2. Go to "Build Phases" tab
3. Expand "Link Binary With Libraries"
4. Click the "+" button
5. Select "OracleSharedFramework.framework" from the project
6. Repeat for the "Oracle WidgetExtension" target

### 4. Update Build Settings
1. Select the "Oracle Of Nonsense iOS" target
2. Go to "Build Settings" tab
3. Search for "Framework Search Paths"
4. Add "$(SRCROOT)/OracleSharedFramework" to the search paths
5. Repeat for the "Oracle WidgetExtension" target

### 5. Update App Group Entitlements
Make sure both the main app and widget have the same App Group identifier:
- group.com.oracleofnonsense.shared

### 6. Copy CSV File to Shared Container
The shared framework will look for the master.csv file in the shared App Group container. Make sure to copy the CSV file there when the app launches.

## Files Created:
- `OracleSharedFramework/PhraseTemplate.swift` - Template-based phrase generation
- `OracleSharedFramework/PhraseGenerator.swift` - Main phrase generation logic with CSV parsing
- `OracleSharedFramework/SharedModels.swift` - Shared data models
- `OracleSharedFramework/CSVManager.swift` - Handles copying CSV to shared container
- `OracleSharedFramework/SharedFrameworkTests.swift` - Test utilities for the framework
- `OracleSharedFramework/master.csv` - CSV data file (moved from app bundle)
- `OracleSharedFramework/Info.plist` - Framework configuration

## Usage:
Both the iOS app and widget now use the same shared framework:
- iOS app: `PhraseGenerator.shared.generatePhrase(chaosMode: Bool)`
- Widget: `PhraseGenerator.shared.generateWidgetPhrase()`

The framework automatically handles:
- App Group shared container access
- CSV file parsing
- Fallback to bundled CSV
- Fallback to hardcoded phrases
