//
//  CSVManager.swift
//  OracleSharedFramework
//
//  Created by Dillon Butler on 9/4/25.
//

import Foundation

public class CSVManager {
    public static let shared = CSVManager()
    
    private let appGroupIdentifier = "group.com.oracleofnonsense.shared"
    
    private init() {}
    
    /// Copies the master.csv file from the framework bundle to the shared App Group container
    /// This should be called when the app launches to ensure the widget can access the CSV data
    public func copyCSVToSharedContainer() {
        guard let sharedContainerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupIdentifier) else {
            print("Failed to get shared container URL")
            return
        }
        
        let csvFileURL = sharedContainerURL.appendingPathComponent("master.csv")
        
        // Check if CSV already exists in shared container
        if FileManager.default.fileExists(atPath: csvFileURL.path) {
            print("CSV file already exists in shared container")
            return
        }
        
        // Try to copy from framework bundle first
        if let frameworkCSVPath = Bundle(for: CSVManager.self).path(forResource: "master", ofType: "csv"),
           let csvContent = try? String(contentsOfFile: frameworkCSVPath, encoding: .utf8) {
            do {
                try csvContent.write(to: csvFileURL, atomically: true, encoding: .utf8)
                print("Successfully copied master.csv from framework to shared container")
                return
            } catch {
                print("Failed to copy CSV from framework to shared container: \(error)")
            }
        }
        
        // Fallback to main bundle
        guard let bundleCSVPath = Bundle.main.path(forResource: "master", ofType: "csv"),
              let csvContent = try? String(contentsOfFile: bundleCSVPath, encoding: .utf8) else {
            print("Failed to find master.csv in framework or main bundle")
            return
        }
        
        do {
            try csvContent.write(to: csvFileURL, atomically: true, encoding: .utf8)
            print("Successfully copied master.csv from main bundle to shared container")
        } catch {
            print("Failed to copy CSV to shared container: \(error)")
        }
    }
    
    /// Verifies that the CSV file is accessible from the shared container
    public func verifySharedCSV() -> Bool {
        guard let sharedContainerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupIdentifier) else {
            return false
        }
        
        let csvFileURL = sharedContainerURL.appendingPathComponent("master.csv")
        return FileManager.default.fileExists(atPath: csvFileURL.path)
    }
}
