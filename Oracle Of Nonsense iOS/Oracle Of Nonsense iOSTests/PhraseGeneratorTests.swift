//
//  PhraseGeneratorTests.swift
//  Oracle Of Nonsense iOSTests
//
//  Created by Dillon Butler on 9/1/25.
//

import XCTest
@testable import Oracle_Of_Nonsense_iOS

final class PhraseGeneratorTests: XCTestCase {
    
    var phraseGenerator: PhraseGenerator!
    
    override func setUpWithError() throws {
        phraseGenerator = PhraseGenerator.shared
    }
    
    override func tearDownWithError() throws {
        phraseGenerator = nil
    }
    
    // MARK: - PhraseTemplate Tests
    
    func testPhraseTemplateInitialization() throws {
        let template = PhraseTemplate(
            structure: "The {noun} {verb}",
            nouns: ["moon", "star"],
            verbs: ["shines", "glows"]
        )
        
        XCTAssertEqual(template.structure, "The {noun} {verb}")
        XCTAssertEqual(template.nouns, ["moon", "star"])
        XCTAssertEqual(template.verbs, ["shines", "glows"])
    }
    
    func testPhraseTemplateGeneratePhrase() throws {
        let template = PhraseTemplate(
            structure: "The {noun} {verb}",
            nouns: ["moon"],
            verbs: ["shines"]
        )
        
        let phrase = template.generatePhrase()
        XCTAssertTrue(phrase.hasPrefix("The moon shines"))
        XCTAssertTrue(phrase.hasSuffix("."))
    }
    
    func testPhraseTemplateWithMultiplePlaceholders() throws {
        let template = PhraseTemplate(
            structure: "The {noun} {verb} the {noun2}",
            nouns: ["wind"],
            verbs: ["whispers"],
            nouns2: ["truth"]
        )
        
        let phrase = template.generatePhrase()
        XCTAssertTrue(phrase.contains("wind"))
        XCTAssertTrue(phrase.contains("whispers"))
        XCTAssertTrue(phrase.contains("truth"))
        XCTAssertTrue(phrase.hasSuffix("."))
    }
    
    func testPhraseTemplateCapitalization() throws {
        let template = PhraseTemplate(
            structure: "the {noun} {verb}",
            nouns: ["moon"],
            verbs: ["shines"]
        )
        
        let phrase = template.generatePhrase()
        XCTAssertTrue(phrase.hasPrefix("The"))
        XCTAssertTrue(phrase.hasSuffix("."))
    }
    
    // MARK: - PhraseGenerator Tests
    
    func testPhraseGeneratorSingleton() throws {
        let instance1 = PhraseGenerator.shared
        let instance2 = PhraseGenerator.shared
        
        XCTAssertIdentical(instance1, instance2)
    }
    
    func testGeneratePhraseNormalMode() throws {
        let phrase = phraseGenerator.generatePhrase(chaosMode: false)
        
        XCTAssertFalse(phrase.isEmpty)
        XCTAssertTrue(phrase.hasSuffix("."))
    }
    
    func testGeneratePhraseChaosMode() throws {
        let phrase = phraseGenerator.generatePhrase(chaosMode: true)
        
        XCTAssertFalse(phrase.isEmpty)
        XCTAssertTrue(phrase.hasSuffix("."))
    }
    
    func testGeneratePhraseMultipleCalls() throws {
        let phrases = (0..<10).map { _ in
            phraseGenerator.generatePhrase(chaosMode: false)
        }
        
        // Should be able to generate multiple phrases
        XCTAssertEqual(phrases.count, 10)
        
        // All phrases should be valid
        for phrase in phrases {
            XCTAssertFalse(phrase.isEmpty)
            XCTAssertTrue(phrase.hasSuffix("."))
        }
    }
    
    func testGeneratePhraseChaosModeMultipleCalls() throws {
        let phrases = (0..<10).map { _ in
            phraseGenerator.generatePhrase(chaosMode: true)
        }
        
        // Should be able to generate multiple phrases
        XCTAssertEqual(phrases.count, 10)
        
        // All phrases should be valid
        for phrase in phrases {
            XCTAssertFalse(phrase.isEmpty)
            XCTAssertTrue(phrase.hasSuffix("."))
        }
    }
    
    // MARK: - CSV Parsing Tests
    
    func testCSVParsing() throws {
        let csvContent = """
        The moon whispers secrets
        The stars dance in the sky
        # This is a comment
        The wind carries ancient wisdom
        
        """
        
        let phrases = PhraseGenerator.parseCsvToPhrases(csvContent)
        
        XCTAssertEqual(phrases.count, 3)
        XCTAssertTrue(phrases.contains("The moon whispers secrets"))
        XCTAssertTrue(phrases.contains("The stars dance in the sky"))
        XCTAssertTrue(phrases.contains("The wind carries ancient wisdom"))
        XCTAssertFalse(phrases.contains("# This is a comment"))
    }
    
    func testCSVParsingWithCommas() throws {
        let csvContent = """
        The moon whispers secrets, additional info
        The stars dance in the sky, more info
        The wind carries ancient wisdom, extra data
        """
        
        let phrases = PhraseGenerator.parseCsvToPhrases(csvContent)
        
        XCTAssertEqual(phrases.count, 3)
        XCTAssertTrue(phrases.contains("The moon whispers secrets"))
        XCTAssertTrue(phrases.contains("The stars dance in the sky"))
        XCTAssertTrue(phrases.contains("The wind carries ancient wisdom"))
    }
    
    func testCSVParsingEmptyLines() throws {
        let csvContent = """
        The moon whispers secrets
        
        The stars dance in the sky
        
        
        The wind carries ancient wisdom
        """
        
        let phrases = PhraseGenerator.parseCsvToPhrases(csvContent)
        
        XCTAssertEqual(phrases.count, 3)
        XCTAssertTrue(phrases.contains("The moon whispers secrets"))
        XCTAssertTrue(phrases.contains("The stars dance in the sky"))
        XCTAssertTrue(phrases.contains("The wind carries ancient wisdom"))
    }
}
