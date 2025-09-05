//
//  WidgetPhraseGenerator.swift
//  Oracle Widget
//
//  Created by Dillon Butler on 9/4/25.
//

import Foundation

class WidgetPhraseGenerator {
    static let shared = WidgetPhraseGenerator()
    
    private let csvPhrases: [String] = {
        guard let path = Bundle.main.path(forResource: "master", ofType: "csv"),
              let content = try? String(contentsOfFile: path, encoding: .utf8) else {
            // Fallback phrases if CSV file is not found
            return [
                "The oracle is silent today.",
                "Your path winds through starlight.",
                "The moon whispers secrets to the night.",
                "In the space between breaths, magic lives.",
                "The ancient stones remember your name."
            ]
        }
        
        return WidgetPhraseGenerator.parseCsvToPhrases(content)
    }()
    
    private static func parseCsvToPhrases(_ text: String) -> [String] {
        return text
            .split(separator: "\n")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty && !$0.hasPrefix("#") }
            .map { line in
                // Handle CSV format - take first column if comma-separated
                if line.contains(",") {
                    let components = line.split(separator: ",", maxSplits: 1)
                    return String(components[0]).trimmingCharacters(in: .whitespacesAndNewlines)
                }
                return line
            }
            .filter { !$0.isEmpty }
    }
    
    private init() {}
    
    func generatePhrase(chaosMode: Bool) -> String {
        // Widget only uses CSV phrases, ignores chaos mode
        return csvPhrases.randomElement() ?? "The oracle is silent today."
    }
}
