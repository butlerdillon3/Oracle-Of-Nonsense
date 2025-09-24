//
//  PhraseGenerator.swift
//  OracleSharedFramework
//
//  Created by Dillon Butler on 9/4/25.
//

import Foundation

public class PhraseGenerator {
    public static let shared = PhraseGenerator()
    
    private let templates: [PhraseTemplate] = [
        PhraseTemplate(
            structure: "the {noun} {verb}, {noun2} {verb2}",
            nouns: ["veil", "moon", "wind", "river", "star", "shadow", "light", "dream", "silence", "whisper", "echo", "mirror", "gate", "bridge", "path", "door", "window", "curtain", "fog", "mist", "cloud", "storm", "thunder", "lightning", "rain", "snow", "frost", "dew", "dawn", "dusk", "twilight", "sunrise", "sunset", "midnight", "noon", "hour", "minute", "second", "moment", "instant", "eternity", "infinity", "crystal", "gemstone", "pearl", "diamond", "emerald", "sapphire", "ruby", "opal", "amethyst", "topaz", "obsidian", "jade", "turquoise", "lapis", "onyx", "garnet", "agate", "carnelian", "chrysoprase", "moonstone", "sunstone", "bloodstone", "tiger's eye", "cat's eye", "hawk's eye", "falcon's eye", "eagle's eye", "wolf's eye", "dragon's eye", "phoenix's eye", "unicorn's horn", "dragon's scale", "phoenix's feather", "unicorn's mane", "dragon's breath", "phoenix's song", "unicorn's tear", "dragon's heart", "phoenix's soul", "unicorn's spirit"],
            verbs: ["thins", "speaks", "dances", "flows", "shimmers", "whispers", "glows", "breathes", "moves", "shifts", "changes", "reveals", "hides", "opens", "closes", "rises", "falls", "turns", "spins", "swirls", "twirls", "waltzes", "leaps", "bounds", "springs", "jumps", "floats", "drifts", "wanders", "roams", "travels", "journeys", "explores", "discovers", "creates", "destroys", "builds", "breaks", "heals", "wounds", "blesses", "curses", "illuminates", "darkens", "transforms", "manifests", "materializes", "dissolves", "condenses", "evaporates", "pulses", "beats", "quivers", "trembles", "shakes", "vibrates", "resonates", "echoes", "reverberates", "amplifies", "diminishes", "expands", "contracts", "ascends", "descends", "emerges", "submerges", "radiates", "emanates", "pulsates", "oscillates", "undulates", "ripples", "cascades", "tumbles", "spirals", "orbits", "waxes", "wanes"],
            nouns2: ["truth", "wisdom", "destiny", "fortune", "clarity", "peace", "hope", "love", "courage", "strength", "beauty", "grace", "power", "magic", "mystery", "serenity", "harmony", "balance", "freedom", "joy", "sorrow", "pain", "pleasure", "ecstasy", "agony", "bliss", "misery", "enlightenment", "ignorance", "knowledge", "understanding", "insight", "foresight", "hindsight", "memory", "forgetting", "learning", "teaching", "growth", "aging", "dying", "living", "compassion", "empathy", "kindness", "generosity", "humility", "patience", "perseverance", "resilience", "adaptability", "creativity"],
            verbs2: ["glimmers", "shines", "flows", "dances", "speaks", "whispers", "glows", "breathes", "moves", "shifts", "changes", "reveals", "hides", "opens", "closes", "rises", "falls", "turns", "spins", "sparkles", "twinkles", "flickers", "pulses", "beats", "quivers", "trembles", "shakes", "vibrates", "resonates", "echoes", "reverberates", "amplifies", "diminishes", "grows", "shrinks", "expands", "contracts", "ascends", "descends", "emerges", "submerges", "radiates", "emanates", "pulsates", "oscillates", "undulates", "ripples", "cascades", "tumbles", "spirals", "orbits"]
        ),
        PhraseTemplate(
            structure: "you already {verb} the {noun}",
            nouns: ["answer", "truth", "path", "way", "direction", "purpose", "meaning", "reason", "cause", "source", "root", "heart", "soul", "spirit", "essence", "nature", "form", "shape", "pattern", "design", "plan", "strategy", "method", "approach", "solution", "problem", "challenge", "obstacle", "barrier", "wall", "door", "gate", "bridge", "tunnel", "road", "street", "avenue", "boulevard", "highway", "freeway", "pathway", "walkway", "trail", "compass", "map", "guide", "signpost", "milestone", "landmark", "beacon", "lighthouse", "star", "constellation", "north"],
            verbs: ["know", "feel", "see", "hear", "sense", "understand", "remember", "recognize", "hold", "carry", "possess", "own", "embrace", "accept", "love", "trust", "believe", "hope", "dream", "wish", "desire", "crave", "long", "yearn", "ache", "hurt", "heal", "grow", "learn", "teach", "share", "give", "receive", "create", "destroy", "build", "break", "mend", "fix", "solve", "answer", "question", "wonder", "doubt", "perceive", "intuit", "foresee", "anticipate", "envision", "imagine", "conceive", "realize", "discover", "uncover", "grasp", "comprehend", "apprehend", "fathom", "penetrate", "pierce", "unlock", "decode", "decipher", "interpret", "translate", "transform", "transmute", "alchemize", "crystallize", "manifest", "materialize", "dematerialize", "etherealize", "spiritualize", "embody", "incarnate", "disincarnate", "ascend", "descend", "transcend", "descend", "evolve", "devolve", "progress", "regress", "advance", "retreat", "expand", "contract", "dilate", "constrict"]
        ),
        PhraseTemplate(
            structure: "listen for the {adjective} {noun}",
            nouns: ["yes", "no", "answer", "voice", "sound", "whisper", "call", "song", "word", "message", "sign", "signal", "hint", "clue", "truth", "wisdom", "guidance", "direction", "path", "way", "road", "street", "avenue", "boulevard", "highway", "freeway", "pathway", "walkway", "trail", "track", "route", "course", "journey", "adventure", "experience", "lesson", "gift", "blessing", "curse", "reward", "punishment", "consequence", "revelation", "epiphany", "awakening", "realization", "discovery", "insight", "foresight", "prophecy", "omen", "portent", "significance"],
            adjectives: ["softest", "gentlest", "quietest", "sweetest", "truest", "purest", "deepest", "highest", "brightest", "clearest", "strongest", "wisest", "kindest", "bravest", "loveliest", "fairest", "noblest", "grandest", "finest", "best", "darkest", "lowest", "weakest", "foolish", "cruelest", "ugliest", "meanest", "worst", "loudest", "harshest", "roughest", "smoother", "sharper", "duller", "faster", "slower", "hotter", "colder", "wetter", "drier", "heavier", "lighter", "most ethereal", "most celestial", "most divine", "most sacred", "most mystical", "most enchanting", "most mesmerizing", "most captivating", "most alluring", "most bewitching"]
        ),
        PhraseTemplate(
            structure: "{noun} {verb} the {noun2}",
            nouns: ["intention", "focus", "desire", "hope", "dream", "wish", "prayer", "thought", "mind", "heart", "soul", "spirit", "will", "power", "strength", "courage", "love", "faith", "trust", "belief", "doubt", "fear", "anger", "hate", "envy", "jealousy", "pride", "humility", "gratitude", "forgiveness", "mercy", "justice", "truth", "honesty", "integrity", "honor", "dignity", "respect", "admiration", "appreciation", "recognition", "acknowledgment", "determination", "resolve", "commitment", "dedication", "devotion", "loyalty", "fidelity", "constancy", "steadfastness", "perseverance"],
            verbs: ["tunes", "sets", "aligns", "matches", "connects", "joins", "unites", "harmonizes", "balances", "centers", "grounds", "elevates", "raises", "lifts", "opens", "expands", "grows", "develops", "evolves", "transforms", "changes", "alters", "modifies", "adjusts", "adapts", "conforms", "resists", "defies", "challenges", "accepts", "rejects", "embraces", "denies", "affirms", "confirms", "validates", "invalidates", "supports", "opposes", "helps", "hinders", "facilitates", "orchestrates", "conducts", "directs", "guides", "steers", "navigates", "pilots", "captains", "leads", "influences", "shapes"],
            nouns2: ["frequency", "vibration", "energy", "rhythm", "flow", "current", "stream", "wave", "pulse", "beat", "harmony", "balance", "alignment", "connection", "unity", "oneness", "wholeness", "completeness", "perfection", "beauty", "ugliness", "goodness", "evil", "right", "wrong", "truth", "falsehood", "reality", "illusion", "fact", "fiction", "myth", "legend", "story", "tale", "narrative", "account", "report", "description", "explanation", "interpretation", "understanding", "resonance", "synchronization", "coherence", "consonance", "accord", "concord", "symmetry", "proportion", "equilibrium", "stability", "foundation"]
        ),
        PhraseTemplate(
            structure: "{noun} {verb} between {noun2}",
            nouns: ["destiny", "fate", "fortune", "luck", "chance", "opportunity", "possibility", "potential", "future", "tomorrow", "hope", "dream", "wish", "prayer", "thought", "mind", "heart", "soul", "spirit", "body", "flesh", "bone", "blood", "breath", "life", "death", "birth", "rebirth", "transformation", "metamorphosis", "evolution", "revolution", "revelation", "apocalypse", "enlightenment", "awakening", "realization", "recognition", "discovery", "invention", "creation", "destruction", "karma", "dharma", "samsara", "nirvana", "zen", "tao", "chi", "prana", "mana", "essence", "spark"],
            verbs: ["speaks", "whispers", "calls", "sings", "dances", "flows", "moves", "shifts", "changes", "reveals", "hides", "opens", "closes", "rises", "falls", "turns", "spins", "flows", "breathes", "lives", "dies", "grows", "decays", "heals", "wounds", "blesses", "curses", "helps", "hinders", "guides", "misleads", "teaches", "learns", "gives", "takes", "creates", "destroys", "builds", "breaks", "mends", "splits", "unites", "mediates", "arbitrates", "negotiates", "reconciles", "bridges", "connects", "links", "joins", "unifies", "harmonizes", "balances"],
            nouns2: ["thoughts", "dreams", "hopes", "fears", "doubts", "beliefs", "memories", "visions", "ideas", "feelings", "emotions", "senses", "moments", "breaths", "heartbeats", "steps", "moves", "changes", "shifts", "flows", "rivers", "streams", "oceans", "seas", "lakes", "ponds", "pools", "springs", "wells", "fountains", "waterfalls", "rapids", "whirlpools", "eddies", "currents", "tides", "waves", "ripples", "splashes", "drops", "tears", "sweat", "consciousness", "awareness", "mindfulness", "presence", "attention", "focus", "concentration", "meditation", "contemplation", "reflection", "introspection"]
        )
    ]
    
    private let csvPhrases: [String] = {
        // Try to get CSV from framework bundle first
        if let frameworkPath = Bundle(for: PhraseGenerator.self).path(forResource: "master", ofType: "csv"),
           let content = try? String(contentsOfFile: frameworkPath, encoding: .utf8) {
            return PhraseGenerator.parseCsvToPhrases(content)
        }
        
        // Try to get CSV from shared container (for App Groups)
        let appGroupIdentifier = "group.com.oracleofnonsense.shared"
        if let sharedContainerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupIdentifier) {
            let csvFileURL = sharedContainerURL.appendingPathComponent("master.csv")
            if let content = try? String(contentsOf: csvFileURL, encoding: .utf8) {
                return PhraseGenerator.parseCsvToPhrases(content)
            }
        }
        
        // Fallback to main bundle
        guard let path = Bundle.main.path(forResource: "master", ofType: "csv"),
              let content = try? String(contentsOfFile: path, encoding: .utf8) else {
            // Final fallback phrases if CSV file is not found
            return [
                "The oracle is silent today.",
                "Your path winds through starlight.",
                "The moon whispers secrets to the night.",
                "In the space between breaths, magic lives.",
                "The ancient stones remember your name."
            ]
        }
        
        return PhraseGenerator.parseCsvToPhrases(content)
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
    
    public func generatePhrase(chaosMode: Bool) -> String {
        if chaosMode {
            return templates.randomElement()?.generatePhrase() ?? "The oracle is silent today."
        } else {
            return csvPhrases.randomElement() ?? "The oracle is silent today."
        }
    }
    
    // Widget-specific method that only uses CSV phrases
    public func generateWidgetPhrase() -> String {
        return csvPhrases.randomElement() ?? "The oracle is silent today."
    }
}
