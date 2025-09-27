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
    
    // New parameters for expanded templates
    public let time: [String]?
    public let adjective: [String]?
    public let noun: [String]?
    public let verb: [String]?
    public let preposition: [String]?
    public let something: [String]?
    
    public init(structure: String, 
                nouns: [String]? = nil, 
                verbs: [String]? = nil, 
                nouns2: [String]? = nil, 
                verbs2: [String]? = nil, 
                nouns3: [String]? = nil, 
                nouns4: [String]? = nil, 
                adjectives: [String]? = nil, 
                adjectives2: [String]? = nil,
                time: [String]? = nil,
                adjective: [String]? = nil,
                noun: [String]? = nil,
                verb: [String]? = nil,
                preposition: [String]? = nil,
                something: [String]? = nil) {
        self.structure = structure
        self.nouns = nouns
        self.verbs = verbs
        self.nouns2 = nouns2
        self.verbs2 = verbs2
        self.nouns3 = nouns3
        self.nouns4 = nouns4
        self.adjectives = adjectives
        self.adjectives2 = adjectives2
        self.time = time
        self.adjective = adjective
        self.noun = noun
        self.verb = verb
        self.preposition = preposition
        self.something = something
    }
    
    public func generatePhrase() -> String {
        var phrase = structure
        
        // Replace placeholders with random words from their respective arrays
        // Handle all placeholder types systematically
        
        // Time placeholders
        if let time = time {
            phrase = phrase.replacingOccurrences(of: "{time}", with: time.randomElement() ?? "")
        }
        
        // Adjective placeholders (handle both old and new style)
        if let adjectives = adjectives {
            phrase = phrase.replacingOccurrences(of: "{adjective}", with: adjectives.randomElement() ?? "")
        }
        if let adjectives2 = adjectives2 {
            phrase = phrase.replacingOccurrences(of: "{adjective2}", with: adjectives2.randomElement() ?? "")
        }
        // Handle new-style adjective parameter
        if let adjective = adjective {
            phrase = phrase.replacingOccurrences(of: "{adjective}", with: adjective.randomElement() ?? "")
        }
        
        // Noun placeholders (handle all variants)
        if let nouns = nouns {
            phrase = phrase.replacingOccurrences(of: "{noun}", with: nouns.randomElement() ?? "")
        }
        if let nouns2 = nouns2 {
            phrase = phrase.replacingOccurrences(of: "{noun2}", with: nouns2.randomElement() ?? "")
        }
        if let nouns3 = nouns3 {
            phrase = phrase.replacingOccurrences(of: "{noun3}", with: nouns3.randomElement() ?? "")
        }
        if let nouns4 = nouns4 {
            phrase = phrase.replacingOccurrences(of: "{noun4}", with: nouns4.randomElement() ?? "")
        }
        // Handle new-style noun parameter
        if let noun = noun {
            phrase = phrase.replacingOccurrences(of: "{noun}", with: noun.randomElement() ?? "")
        }
        
        // Verb placeholders (handle all variants)
        if let verbs = verbs {
            phrase = phrase.replacingOccurrences(of: "{verb}", with: verbs.randomElement() ?? "")
        }
        if let verbs2 = verbs2 {
            phrase = phrase.replacingOccurrences(of: "{verb2}", with: verbs2.randomElement() ?? "")
        }
        // Handle new-style verb parameter
        if let verb = verb {
            phrase = phrase.replacingOccurrences(of: "{verb}", with: verb.randomElement() ?? "")
        }
        
        // Other placeholder types
        if let preposition = preposition {
            phrase = phrase.replacingOccurrences(of: "{preposition}", with: preposition.randomElement() ?? "")
        }
        if let something = something {
            phrase = phrase.replacingOccurrences(of: "{something}", with: something.randomElement() ?? "")
        }
        
        // Capitalize the first letter and add a period
        let capitalized = phrase.prefix(1).uppercased() + phrase.dropFirst()
        return capitalized + "."
    }
}
