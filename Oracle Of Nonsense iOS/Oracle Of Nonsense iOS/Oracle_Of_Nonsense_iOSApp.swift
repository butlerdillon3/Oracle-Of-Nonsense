//
//  Oracle_Of_Nonsense_iOSApp.swift
//  Oracle Of Nonsense iOS
//
//  Created by Dillon Butler on 9/1/25.
//

import SwiftUI
import OracleSharedFramework

@main
struct Oracle_Of_Nonsense_iOSApp: App {
    init() {
        // Copy CSV file to shared container for widget access
        CSVManager.shared.copyCSVToSharedContainer()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
