//
//  PhraseTemplate.swift
//  OracleSharedFramework
//
//  Created by Dillon Butler on 9/4/25.
//

import Foundation

public struct PhraseTemplate {
    public let structure: String
    public let nouns: [String]?
    public let verbs: [String]?
    public let nouns2: [String]?
    public let verbs2: [String]?
    public let nouns3: [String]?
    public let nouns4: [String]?
    public let adjectives: [String]?
    public let adjectives2: [String]?
    
    public init(structure: String, nouns: [String]? = nil, verbs: [String]? = nil, nouns2: [String]? = nil, verbs2: [String]? = nil, nouns3: [String]? = nil, nouns4: [String]? = nil, adjectives: [String]? = nil, adjectives2: [String]? = nil) {
        self.structure = structure
        self.nouns = nouns
        self.verbs = verbs
        self.nouns2 = nouns2
        self.verbs2 = verbs2
        self.nouns3 = nouns3
        self.nouns4 = nouns4
        self.adjectives = adjectives
        self.adjectives2 = adjectives2
    }
    
    public func generatePhrase() -> String {
        var phrase = structure
        
        // Replace placeholders with random words from their respective arrays
        if let nouns = nouns {
            phrase = phrase.replacingOccurrences(of: "{noun}", with: nouns.randomElement() ?? "")
        }
        if let verbs = verbs {
            phrase = phrase.replacingOccurrences(of: "{verb}", with: verbs.randomElement() ?? "")
        }
        if let nouns2 = nouns2 {
            phrase = phrase.replacingOccurrences(of: "{noun2}", with: nouns2.randomElement() ?? "")
        }
        if let verbs2 = verbs2 {
            phrase = phrase.replacingOccurrences(of: "{verb2}", with: verbs2.randomElement() ?? "")
        }
        if let nouns3 = nouns3 {
            phrase = phrase.replacingOccurrences(of: "{noun3}", with: nouns3.randomElement() ?? "")
        }
        if let nouns4 = nouns4 {
            phrase = phrase.replacingOccurrences(of: "{noun4}", with: nouns4.randomElement() ?? "")
        }
        if let adjectives = adjectives {
            phrase = phrase.replacingOccurrences(of: "{adjective}", with: adjectives.randomElement() ?? "")
        }
        if let adjectives2 = adjectives2 {
            phrase = phrase.replacingOccurrences(of: "{adjective2}", with: adjectives2.randomElement() ?? "")
        }
        
        // Capitalize the first letter and add a period
        let capitalized = phrase.prefix(1).uppercased() + phrase.dropFirst()
        return capitalized + "."
    }
}
