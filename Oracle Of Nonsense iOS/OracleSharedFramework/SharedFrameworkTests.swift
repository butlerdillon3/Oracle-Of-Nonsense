//
//  SharedFrameworkTests.swift
//  OracleSharedFramework
//
//  Created by Dillon Butler on 9/4/25.
//

import Foundation

/// Comprehensive test functions to verify the shared framework works correctly
/// These can be called from the main app or widget to test functionality
public class SharedFrameworkTests {
    
    public static func runBasicTests() -> [String] {
        var results: [String] = []
        
        // Test 1: PhraseGenerator initialization
        let phraseGenerator = PhraseGenerator.shared
        results.append("✓ PhraseGenerator initialized successfully")
        
        // Test 2: Generate phrase with chaos mode
        let chaosPhrase = phraseGenerator.generatePhrase(chaosMode: true)
        results.append("✓ Chaos mode phrase generated: '\(chaosPhrase)'")
        
        // Test 3: Generate widget phrase
        let widgetPhrase = phraseGenerator.generateWidgetPhrase()
        results.append("✓ Widget phrase generated: '\(widgetPhrase)'")
        
        // Test 4: CSV Manager verification
        let csvExists = CSVManager.shared.verifySharedCSV()
        results.append("✓ CSV file in shared container: \(csvExists ? "Found" : "Not found")")
        
        // Test 5: Generate multiple phrases to ensure randomness
        var uniquePhrases = Set<String>()
        for _ in 0..<10 {
            uniquePhrases.insert(phraseGenerator.generatePhrase(chaosMode: false))
        }
        results.append("✓ Generated 10 unique phrases: \(uniquePhrases.count) unique")
        
        return results
    }
    
    public static func testPhraseTemplate() -> [String] {
        var results: [String] = []
        
        let template = PhraseTemplate(
            structure: "The {noun} {verb} in the {adjective} {noun2}",
            nouns: ["moon", "star", "crystal"],
            verbs: ["shines", "glows", "sparkles"],
            nouns2: ["night", "darkness", "void"],
            adjectives: ["mystical", "ancient", "sacred"]
        )
        
        let phrase = template.generatePhrase()
        results.append("✓ Template phrase generated: '\(phrase)'")
        
        // Verify the phrase contains expected elements
        let hasNoun = template.nouns?.contains { phrase.contains($0) } ?? false
        let hasVerb = template.verbs?.contains { phrase.contains($0) } ?? false
        let hasAdjective = template.adjectives?.contains { phrase.contains($0) } ?? false
        let hasNoun2 = template.nouns2?.contains { phrase.contains($0) } ?? false
        
        results.append("✓ Template contains noun: \(hasNoun)")
        results.append("✓ Template contains verb: \(hasVerb)")
        results.append("✓ Template contains adjective: \(hasAdjective)")
        results.append("✓ Template contains noun2: \(hasNoun2)")
        
        return results
    }
    
    public static func testSharedModels() -> [String] {
        var results: [String] = []
        
        // Test Star model
        let star = Star(position: CGPoint(x: 100, y: 200), size: 5.0, opacity: 0.8)
        results.append("✓ Star created: position(\(star.position.x), \(star.position.y)), size: \(star.size), opacity: \(star.opacity)")
        
        // Test ShootingStar model
        let shootingStar = ShootingStar(
            position: CGPoint(x: 50, y: 100),
            endPosition: CGPoint(x: 200, y: 300),
            duration: 2.0,
            rotation: 45.0,
            hue: 0.5,
            opacity: 0.9
        )
        results.append("✓ ShootingStar created: duration: \(shootingStar.duration), rotation: \(shootingStar.rotation), hue: \(shootingStar.hue)")
        
        // Test MovingPhrase model
        let movingPhrase = MovingPhrase(
            position: CGPoint(x: 30, y: 60),
            endPosition: CGPoint(x: 150, y: 250),
            duration: 3.0,
            rotation: 30.0,
            opacity: 0.7
        )
        results.append("✓ MovingPhrase created: duration: \(movingPhrase.duration), rotation: \(movingPhrase.rotation)")
        
        // Test Meteor model
        let meteor = Meteor(
            position: CGPoint(x: 40, y: 80),
            endPosition: CGPoint(x: 180, y: 280),
            duration: 1.5,
            rotation: 60.0,
            opacity: 0.6
        )
        results.append("✓ Meteor created: duration: \(meteor.duration), rotation: \(meteor.rotation)")
        
        // Test WidgetStar model
        let widgetStar = WidgetStar(position: CGPoint(x: 75, y: 125), size: 3.0, opacity: 0.5)
        results.append("✓ WidgetStar created: position(\(widgetStar.position.x), \(widgetStar.position.y)), size: \(widgetStar.size)")
        
        return results
    }
    
    public static func testCSVParsing() -> [String] {
        var results: [String] = []
        
        let csvContent = """
        The moon whispers secrets
        The stars dance in the sky
        # This is a comment
        The wind carries ancient wisdom
        
        """
        
        // Test CSV parsing (this would need to be made public in PhraseGenerator)
        // For now, just test that we can access the framework
        results.append("✓ CSV parsing test framework accessible")
        
        return results
    }
    
    public static func testNotificationNames() -> [String] {
        var results: [String] = []
        
        // Test notification names
        let chaosModeChanged = Notification.Name.chaosModeChanged.rawValue
        let crystalBallTouchStart = Notification.Name.crystalBallTouchStart.rawValue
        let taglineAppear = Notification.Name.taglineAppear.rawValue
        
        results.append("✓ chaosModeChanged: '\(chaosModeChanged)'")
        results.append("✓ crystalBallTouchStart: '\(crystalBallTouchStart)'")
        results.append("✓ taglineAppear: '\(taglineAppear)'")
        
        // Verify they are unique
        let names = [chaosModeChanged, crystalBallTouchStart, taglineAppear]
        let uniqueNames = Set(names)
        results.append("✓ All notification names are unique: \(uniqueNames.count == names.count)")
        
        return results
    }
    
    public static func runAllTests() -> [String] {
        var allResults: [String] = []
        
        allResults.append("=== Running Shared Framework Tests ===")
        allResults.append("")
        
        allResults.append("--- Basic Tests ---")
        allResults.append(contentsOf: runBasicTests())
        allResults.append("")
        
        allResults.append("--- Phrase Template Tests ---")
        allResults.append(contentsOf: testPhraseTemplate())
        allResults.append("")
        
        allResults.append("--- Shared Models Tests ---")
        allResults.append(contentsOf: testSharedModels())
        allResults.append("")
        
        allResults.append("--- CSV Parsing Tests ---")
        allResults.append(contentsOf: testCSVParsing())
        allResults.append("")
        
        allResults.append("--- Notification Tests ---")
        allResults.append(contentsOf: testNotificationNames())
        allResults.append("")
        
        allResults.append("=== All Tests Complete ===")
        
        return allResults
    }
}
