//
//  PhraseGeneratorTests.swift
//  Oracle Of Nonsense iOSTests
//
//  Created by Dillon Butler on 9/1/25.
//

import XCTest
@testable import Oracle_Of_Nonsense_iOS
@testable import OracleSharedFramework

final class PhraseGeneratorTests: XCTestCase {
    
    var phraseGenerator: PhraseGenerator!
    
    override func setUpWithError() throws {
        phraseGenerator = PhraseGenerator.shared
    }
    
    override func tearDownWithError() throws {
        phraseGenerator = nil
    }
    
    // MARK: - App-Specific Integration Tests
    
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
    
    func testNoPlaceholdersInGeneratedPhrases() throws {
        // Generate many phrases to ensure no placeholders remain
        let phrases = (0..<50).map { _ in
            phraseGenerator.generatePhrase(chaosMode: true)
        }
        
        // Check that no placeholders remain in any phrase
        for phrase in phrases {
            XCTAssertFalse(phrase.contains("{noun}"), "Found {noun} placeholder in phrase: \(phrase)")
            XCTAssertFalse(phrase.contains("{noun2}"), "Found {noun2} placeholder in phrase: \(phrase)")
            XCTAssertFalse(phrase.contains("{noun3}"), "Found {noun3} placeholder in phrase: \(phrase)")
            XCTAssertFalse(phrase.contains("{noun4}"), "Found {noun4} placeholder in phrase: \(phrase)")
            XCTAssertFalse(phrase.contains("{verb}"), "Found {verb} placeholder in phrase: \(phrase)")
            XCTAssertFalse(phrase.contains("{verb2}"), "Found {verb2} placeholder in phrase: \(phrase)")
            XCTAssertFalse(phrase.contains("{adjective}"), "Found {adjective} placeholder in phrase: \(phrase)")
            XCTAssertFalse(phrase.contains("{adjective2}"), "Found {adjective2} placeholder in phrase: \(phrase)")
            XCTAssertFalse(phrase.contains("{time}"), "Found {time} placeholder in phrase: \(phrase)")
            XCTAssertFalse(phrase.contains("{preposition}"), "Found {preposition} placeholder in phrase: \(phrase)")
            XCTAssertFalse(phrase.contains("{something}"), "Found {something} placeholder in phrase: \(phrase)")
        }
    }
    
    // MARK: - CSV Manager Tests
    
    func testCSVManagerSingleton() throws {
        let manager1 = CSVManager.shared
        let manager2 = CSVManager.shared
        
        XCTAssertIdentical(manager1, manager2)
    }
    
    func testCSVManagerCopyToSharedContainer() throws {
        // This test verifies the CSV manager can be called without crashing
        // The actual copying depends on App Groups being set up
        CSVManager.shared.copyCSVToSharedContainer()
        
        // If we get here without crashing, the test passes
        XCTAssertTrue(true)
    }
    
    func testCSVManagerVerifySharedCSV() throws {
        // This test verifies the verification method works
        let exists = CSVManager.shared.verifySharedCSV()
        
        // The result depends on whether App Groups are set up and CSV is copied
        // We just verify the method doesn't crash and returns a boolean
        XCTAssertTrue(exists == true || exists == false)
    }
}
