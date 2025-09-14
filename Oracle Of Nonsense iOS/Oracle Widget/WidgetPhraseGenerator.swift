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
                // Handle CSV format - properly parse quoted fields
                return parseCsvLine(String(line))
            }
            .filter { !$0.isEmpty }
    }
    
    private static func parseCsvLine(_ line: String) -> String {
        var result = ""
        var inQuotes = false
        var quoteChar: Character? = nil
        var i = line.startIndex
        
        while i < line.endIndex {
            let char = line[i]
            
            if (char == "\"" || char == "'") && !inQuotes {
                // Start of quoted field
                inQuotes = true
                quoteChar = char
            } else if char == quoteChar && inQuotes {
                // Check if this is an escaped quote or end of field
                let nextIndex = line.index(after: i)
                if nextIndex < line.endIndex && line[nextIndex] == quoteChar {
                    // Escaped quote, add one quote to result and skip the next
                    result.append(char)
                    i = line.index(after: nextIndex)
                    continue
                } else {
                    // End of quoted field
                    inQuotes = false
                    quoteChar = nil
                }
            } else if char == "," && !inQuotes {
                // Found comma outside quotes, return what we have so far
                return result.trimmingCharacters(in: .whitespacesAndNewlines)
            } else {
                // Regular character, add to result
                result.append(char)
            }
            
            i = line.index(after: i)
        }
        
        return result.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private init() {}
    
    func generatePhrase(chaosMode: Bool) -> String {
        // Widget only uses CSV phrases, ignores chaos mode
        return csvPhrases.randomElement() ?? "The oracle is silent today."
    }
}
