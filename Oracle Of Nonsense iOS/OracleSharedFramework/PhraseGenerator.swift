//
//  PhraseGenerator.swift
//  OracleSharedFramework
//
//  Created by Dillon Butler on 9/4/25.
//

import Foundation
import NaturalLanguage

public class PhraseGenerator {
    public static let shared = PhraseGenerator()
    
    private let templates: [PhraseTemplate] = [

    // 1
    PhraseTemplate(
        structure: "the {noun} {verb}, {noun2} {verb2}",
        nouns: ["veil","moon","wind","river","star","shadow","light","dream","silence","whisper","echo","mirror","gate","bridge","path","door","window","curtain","fog","mist","cloud","storm","thunder","lightning","rain","snow","frost","dew","dawn","dusk","twilight","sunrise","sunset","midnight","noon","hour","minute","second","moment","instant","eternity","infinity","crystal","gemstone","pearl","diamond","emerald","sapphire","ruby","opal","amethyst","topaz","obsidian","jade","turquoise","lapis","onyx","garnet","agate","carnelian","chrysoprase","moonstone","sunstone","bloodstone","tiger's eye","cat's eye","hawk's eye","falcon's eye","eagle's eye","wolf's eye","dragon's eye","phoenix's eye","unicorn's horn","dragon's scale","phoenix's feather","unicorn's mane","dragon's breath","phoenix's song","unicorn's tear","dragon's heart","phoenix's soul","unicorn's spirit","flame","ash","ember","smoke","dust","stone","cavern","peak","abyss","void","chorus","labyrinth","temple","shrine","relic","crown","throne","chalice","lantern","candle","scroll","sigil","rune","glyph","vine","root","sprout","oak","willow","pine","boulder","cliff","shore","isle","archipelago"],
        verbs: ["thins","speaks","dances","flows","shimmers","whispers","glows","breathes","moves","shifts","changes","reveals","hides","opens","closes","rises","falls","turns","spins","swirls","twirls","waltzes","leaps","bounds","springs","jumps","floats","drifts","wanders","roams","travels","journeys","explores","discovers","creates","destroys","builds","breaks","heals","wounds","blesses","curses","illuminates","darkens","transforms","manifests","materializes","dissolves","condenses","evaporates","pulses","beats","quivers","trembles","shakes","vibrates","resonates","echoes","reverberates","amplifies","diminishes","expands","contracts","ascends","descends","emerges","submerges","radiates","emanates","pulsates","oscillates","undulates","ripples","cascades","tumbles","spirals","orbits","waxes","wanes","ignites","smolders","burns","crumbles","erodes","awakens","slumbers","listens","watches","devours","drinks","consumes","exhales","inhales","waits","lingers","remembers","forgets","beseeches","summons","sings","howls","bleeds","weaves","binds","loosens","stirs"],
        nouns2: ["truth","wisdom","destiny","fortune","clarity","peace","hope","love","courage","strength","beauty","grace","power","magic","mystery","serenity","harmony","balance","freedom","joy","sorrow","pain","pleasure","ecstasy","agony","bliss","misery","enlightenment","ignorance","knowledge","understanding","insight","foresight","hindsight","memory","forgetting","learning","teaching","growth","aging","dying","living","compassion","empathy","kindness","generosity","humility","patience","perseverance","resilience","adaptability","creativity","sacrifice","ritual","secret","riddle","paradox","illusion","reflection","absence","void","longing","desire","temptation","redemption","salvation","damnation","prophecy","omen","shadow","echo","song","charm","bane","boon","legacy","lineage","covenant","pact","oath","vow","tithe","tribute","noise","silence","language"],
        verbs2: ["glimmers","shines","flows","dances","speaks","whispers","glows","breathes","moves","shifts","changes","reveals","hides","opens","closes","rises","falls","turns","spins","sparkles","twinkles","flickers","pulses","beats","quivers","trembles","shakes","vibrates","resonates","echoes","reverberates","amplifies","diminishes","grows","shrinks","expands","contracts","ascends","descends","emerges","submerges","radiates","emanates","pulsates","oscillates","undulates","ripples","cascades","tumbles","spirals","orbits","weaves","entwines","lingers","waits","calls","invites","warns","remembers","forgets","burns","kindles","ignites","consumes","sings","cries","sighs","laughs","wails","murmurs","hums","tells","hides","splinters","binds"]
    ),

    // 2
    PhraseTemplate(
        structure: "you already {verb} the {noun}",
        nouns: ["answer","truth","path","way","direction","purpose","meaning","reason","cause","source","root","heart","soul","spirit","essence","nature","form","shape","pattern","design","plan","strategy","method","approach","solution","problem","challenge","obstacle","barrier","wall","door","gate","bridge","tunnel","road","street","avenue","boulevard","highway","freeway","pathway","walkway","trail","compass","map","guide","signpost","milestone","landmark","beacon","lighthouse","star","constellation","north","mystery","secret","key","lock","puzzle","mirror","mask","labyrinth","thread","chain","knot","bond","vow","destiny","horizon","threshold","riddle","silence","void","question","offering","altar","ritual","keystone","anchor","anchorpoint","ledger","record","archive","name","title","story","chronicle","memory","scar","mark"],
        verbs: ["know","feel","see","hear","sense","understand","remember","recognize","hold","carry","possess","own","embrace","accept","love","trust","believe","hope","dream","wish","desire","crave","long","yearn","ache","hurt","heal","grow","learn","teach","share","give","receive","create","destroy","build","break","mend","fix","solve","answer","question","wonder","doubt","perceive","intuit","foresee","anticipate","envision","imagine","conceive","realize","discover","uncover","grasp","comprehend","apprehend","fathom","penetrate","pierce","unlock","decode","decipher","interpret","translate","transform","transmute","alchemize","crystallize","manifest","materialize","dematerialize","etherealize","spiritualize","embody","incarnate","disincarnate","ascend","descend","transcend","evolve","devolve","progress","regress","advance","retreat","expand","contract","dilate","constrict","unravel","weave","entwine","ignite","extinguish","conceal","reveal","mask","mirror","project","summon","invoke","banish","dissolve","fracture","mend","echo","reflect","betray","holdfast","release"]
    ),

    // 3
    PhraseTemplate(
        structure: "listen for the {adjective} {noun}",
        nouns: ["yes","no","answer","voice","sound","whisper","call","song","word","message","sign","signal","hint","clue","truth","wisdom","guidance","direction","path","way","road","street","avenue","boulevard","highway","freeway","pathway","walkway","trail","track","route","course","journey","adventure","experience","lesson","gift","blessing","curse","reward","punishment","consequence","revelation","epiphany","awakening","realization","discovery","insight","foresight","prophecy","omen","portent","significance","prayer","silence","hum","breath","rhythm","echo","drum","bell","chime","gong","thunder","lightning","flame","spark","ember","wave","tide","rustle","murmur","chant","chorus","hymn","dirge","lament","psalm"],
        adjectives: ["softest","gentlest","quietest","sweetest","truest","purest","deepest","highest","brightest","clearest","strongest","wisest","kindest","bravest","loveliest","fairest","noblest","grandest","finest","best","darkest","lowest","weakest","foolish","cruelest","ugliest","meanest","worst","loudest","harshest","roughest","smoother","sharper","duller","faster","slower","hotter","colder","wetter","drier","heavier","lighter","most ethereal","most celestial","most divine","most sacred","most mystical","most enchanting","most mesmerizing","most captivating","most alluring","most bewitching","earliest","latest","forgotten","remembered","hidden","secret","forbidden","eternal","fleeting","vanishing","echoing","haunting","burning","frozen","restless","wandering","waiting","hollow","heavy","weightless","timeless"]
    ),

    // 4
    PhraseTemplate(
        structure: "{noun} {verb} the {noun2}",
        nouns: ["intention","focus","desire","hope","dream","wish","prayer","thought","mind","heart","soul","spirit","will","power","strength","courage","love","faith","trust","belief","doubt","fear","anger","hate","envy","jealousy","pride","humility","gratitude","forgiveness","mercy","justice","truth","honesty","integrity","honor","dignity","respect","admiration","appreciation","recognition","acknowledgment","determination","resolve","commitment","dedication","devotion","loyalty","fidelity","constancy","steadfastness","perseverance","instinct","shadow","silence","word","song","ritual","vow","curse","blessing","destiny","fate","fortune","chance","chaos","order","law","void","abyss","echo","promise","oath","memory","image","vision","pattern","signal"],
        verbs: ["tunes","sets","aligns","matches","connects","joins","unites","harmonizes","balances","centers","grounds","elevates","raises","lifts","opens","expands","grows","develops","evolves","transforms","changes","alters","modifies","adjusts","adapts","conforms","resists","defies","challenges","accepts","rejects","embraces","denies","affirms","confirms","validates","invalidates","supports","opposes","helps","hinders","facilitates","orchestrates","conducts","directs","guides","steers","navigates","pilots","captains","leads","influences","shapes","illuminates","shadows","cloaks","veils","unmasks","awakens","lulls","entwines","unravels","binds","severs","casts","invokes","banishes","kindles","extinguishes","echoes","repeats","balances","disturbs"],
        nouns2: ["frequency","vibration","energy","rhythm","flow","current","stream","wave","pulse","beat","harmony","balance","alignment","connection","unity","oneness","wholeness","completeness","perfection","beauty","ugliness","goodness","evil","right","wrong","truth","falsehood","reality","illusion","fact","fiction","myth","legend","story","tale","narrative","account","report","description","explanation","interpretation","understanding","resonance","synchronization","coherence","consonance","accord","concord","symmetry","proportion","equilibrium","stability","foundation","silence","void","abyss","paradox","secret","mystery","prophecy","omen","riddle","labyrinth","horizon","dawn","dusk","eclipse","shadow","flame","ember","smoke","ash","starfire"]
    ),

    // 5
    PhraseTemplate(
        structure: "{noun} {verb} between {noun2}",
        nouns: ["destiny","fate","fortune","luck","chance","opportunity","possibility","potential","future","tomorrow","hope","dream","wish","prayer","thought","mind","heart","soul","spirit","body","flesh","bone","blood","breath","life","death","birth","rebirth","transformation","metamorphosis","evolution","revolution","revelation","apocalypse","enlightenment","awakening","realization","recognition","discovery","invention","creation","destruction","karma","dharma","samsara","nirvana","zen","tao","chi","prana","mana","essence","spark","truth","lie","mask","mirror","shadow","echo","silence","pact","covenant","blessing","curse","labyrinth","key","threshold","horizon","crossing","bridge","rift","fault","boundary"],
        verbs: ["speaks","whispers","calls","sings","dances","flows","moves","shifts","changes","reveals","hides","opens","closes","rises","falls","turns","spins","flows","breathes","lives","dies","grows","decays","heals","wounds","blesses","curses","helps","hinders","guides","misleads","teaches","learns","gives","takes","creates","destroys","builds","breaks","mends","splits","unites","mediates","arbitrates","negotiates","reconciles","bridges","connects","links","joins","unifies","harmonizes","balances","splits","fractures","divides","fuses","melds","entangles","untangles","weaves"],
        nouns2: ["thoughts", "dreams", "hopes", "fears", "doubts", "beliefs", "memories", "visions", "ideas", "feelings", "emotions", "senses", "moments", "breaths", "heartbeats", "steps", "moves", "changes", "shifts", "flows", "rivers", "streams", "oceans", "seas", "lakes", "ponds", "pools", "springs", "wells", "fountains", "waterfalls", "rapids", "whirlpools", "eddies", "currents", "tides", "waves", "ripples", "splashes", "drops", "tears", "sweat", "consciousness", "awareness", "mindfulness", "presence", "attention", "focus", "concentration", "meditation", "contemplation", "reflection", "introspection"]
    ),

    // 6 (new)
    PhraseTemplate(
        structure: "the {adjective} {noun} will {verb}",
        nouns: ["path","flame","shadow","echo","word","silence","star","moon","sun","storm","tide","labyrinth","mask","mirror","threshold","door","key","cairn","lantern","torch","altar","tablet","scroll","sigil","keystone","keel","helm","banner","crest","harbor","river","bridge","pillar","spire","arch","vault","grove","glade","glen","cliff","cavern","forge","anvil","bell","wharf","harrow","thresh","harvest"],
        verbs: ["guide","deceive","open","close","awaken","slumber","reveal","conceal","burn","freeze","linger","vanish","return","transform","consume","carve","mend","fracture","bind","release","call","answer","beckon","repel","anchor","untether","rise","fall","change","hush","waken","sleep","hollow","fill","empty","kindle","douse","echo","silence","grow","shrink","split","meld","languish","flourish","shine","fade"],
        adjectives: ["forgotten","hidden","sacred","profane","eternal","fleeting","cursed","blessed","hollow","radiant","veiled","secret","haunted","ancient","newborn","patient","restless","warm","cold","silent","thundering","glimmering","ashen","verdant","crimson","azure","obsidian","iridescent","luminous","shadowed","timeless","mortal","divine","forbidden","ordained","forgotten","renewed","withered","blooming","trembling","steadfast","restorative"]
    ),

    // 7 (new)
    PhraseTemplate(
        structure: "between the {noun} and the {noun2}, {something} {verb}",
        nouns: ["sun","moon","star","flame","river","mountain","sky","abyss","silence","shadow","mask","mirror","storm","night","dawn","dusk","island","sea","shore","cliff","valley","plain","forest","grove","temple","altar","ruin","tower","spire","gate","portal"],
        verbs: ["waits","hides","lingers","calls","sings","weeps","burns","flickers","vanishes","echoes","opens","closes","remembers","forgets","leans","leans away","watches","listens","speaks","keeps","breaks","binds","unbinds","cries","smiles","dreams","bleeds"],
        nouns2: ["truth","lie","secret","riddle","threshold","gate","key","door","path","fate","destiny","dream","memory","silence","horizon","edge","border","boundary","rift","bridge","crossing","mirror","reflection","echo","void","tomb","archive","archive","vault"],
        something: ["a whisper","the answer","the question","your shadow","the omen","the silence","the flame","the mask","the song","a bell","a child","an old woman","a raven","a compass","a coin","a key","the last leaf","the first snow","a stone","a promise","a lie","a riddle","a promise","a map"]
    ),

    // 8 (new)
    PhraseTemplate(
        structure: "only the {noun} can {verb} the {noun2}",
        nouns: ["seer","dream","silence","riddle","mask","mirror","flame","star","moon","sun","shadow","secret","oracle","key","threshold","child","thief","priest","wanderer","stranger","singer","poet","hermit","king","queen","smith","cobbler","healer","midwife","sage"],
        verbs: ["open","close","reveal","conceal","awaken","silence","ignite","extinguish","redeem","damn","bind","sever","remember","forget","translate","read","unbind","bind","trace","erase","write","rewrite","forgive","avenge","repair","sunder","tame","untame"],
        nouns2: ["truth","lie","fate","destiny","path","door","gate","labyrinth","riddle","silence","void","abyss","flame","mask","prophecy","name","song","oath","covenant","map","mirror","image","memory","story","legend"]
    ),

    // 9 (new)
    PhraseTemplate(
        structure: "when the {noun} {verb}, the {noun2} will {verb2}",
        nouns: ["moon","sun","star","flame","storm","river","shadow","silence","echo","mask","mirror","labyrinth","oracle","serpent","bird","wolf","lion","crow","dawn","pillar","tower","bell","tide","harvest","winter"],
        verbs: ["rises","falls","burns","flickers","fades","hides","reveals","opens","closes","awakens","sleeps","devours","sings","whispers","howls","strikes","turns","spins","skips","halts","flow","freeze","melt","shiver","thaw"],
        nouns2: ["truth","prophecy","fate","dream","memory","silence","abyss","door","path","mask","reflection","threshold","omen","harvest","kingdom","crown","radar","bridge","story","song"],
        verbs2: ["emerge","vanish","awaken","slumber","speak","conceal","echo","burn","dissolve","transform","guide","deceive","shatter","heal","bind","untangle","open","close","answer","question"]
    ),

    // 10 (new)
    PhraseTemplate(
        structure: "do not {verb} the {adjective} {noun}",
        nouns: ["path","door","key","mask","mirror","flame","shadow","silence","oracle","star","moon","sun","serpent","wolf","bird","whisper","song","altar","tome","relic","chalice","bell","stone","tree","seed","root","thorn","vine","spear","crown","throne"],
        verbs: ["trust","doubt","follow","ignore","deny","embrace","awaken","silence","reveal","conceal","invoke","banish","fear","love","forget","remember","mock","praise","touch","break","enter","leave","speak to","listen to","feed","starve","feed upon"],
        adjectives: ["false","true","hidden","secret","cursed","sacred","veiled","forgotten","eternal","fleeting","burning","frozen","hollow","radiant","ancient","newborn","stolen","given","small","great","quiet","loud"]
    ),

    // 11 (new)
    PhraseTemplate(
        structure: "{time}, the {adjective} {noun} {verb} {preposition} the {noun2}",
        nouns2: ["stone","sea","sky","horizon","door","threshold","wall","map","book","song","name","face","shadow","flame","lake","river","field","forest","garden","city","village","cave","tomb","ruin"],
        time: ["At dusk","At dawn","At midnight","At noon","When the tide turns","When the bell rings","On the third day","On the last harvest","When the frost melts","When the first leaf falls","On the seventh night","When the moon is new","When the moon is full","At the turning of the year","At the hour of silence"],
        adjective: ["ancient","young","broken","whole","ashen","golden","silver","crimson","stained","pure","shadowed","bright","forgotten","remembered","haunting","calm","frenzied","lonely","crowded","hidden","open"],
        noun: ["tree","bridge","road","heart","eye","hand","voice","tomb","well","altar","mirror","sign","gate","book","letter","stone","road","trail","harbor","flag","banner","throne","bed","cauldron"],
        verb: ["leans","falls","rises","burns","sings","weeps","waits","answers","asks","calls","beckons","stillness","trembles","shudders","blossoms","withers","turns","opens","closes","spills","drips","feeds","hunts","lies"],
        preposition: ["beneath","above","beyond","within","between","inside","outside","before","after","beside","under","over","through","around"]
    ),

    // 12 (new)
    PhraseTemplate(
        structure: "if you {verb}, the {adjective} {noun} will {verb2}",
        nouns: ["door","lock","name","song","riddle","path","map","mirror","book","candle","key","ring","chain","stone","spear","feather","seed","root","leaf","beast"],
        verbs: ["listen","look","step","sing","speak","touch","open","close","call","answer","discard","keep","burn","bury","plant","take","give","break","mend","turn","stay","leave","follow","lead","pray","curse","bless","invite","shun"],
        verbs2: ["open","close","answer","ask","sleep","awaken","return","vanish","mend","break","heal","harm","shift","change","grow","shrink","split","join","reveal","conceal","sing","speak","whisper","roar"],
        adjective: ["quiet","loud","jeweled","broken","small","great","hidden","shimmering","ancient","fresh","cold","warm","wet","dry","soft","hard","hollow","full","sacred","profaned"]
    ),

    // 13 (new)
    PhraseTemplate(
        structure: "what {noun} {verb} is what {noun2} {verb2}",
        nouns: ["you","we","they","time","silence","storm","moon","sun","river","mountain","child","oldman","woman","seed","leaf","flame","shadow","mirror","mask","name","memory","dream"],
        verbs: ["remember","forget","seek","hide","carry","drop","bear","break","mend","know","learn","teach","call","answer","sleep","wake","sing","hide","reveal","grow"],
        nouns2: ["will","fate","future","past","truth","lie","story","song","wall","bridge","path","door","key","shadow","light","echo","ring","tide"],
        verbs2: ["becomes","remains","returns","vanishes","awakens","sleeps","speaks","echoes","sings","falls","rises","turns","spins","breaks","mends","heals"]
    ),

    // 14 (new)
    PhraseTemplate(
        structure: "the {noun} of {noun2} is {adjective}",
        nouns: ["crown","key","song","name","stone","map","door","mirror","flame","shadow","ring","book","word","sigil","seal","mark","path","bridge","echo","promise","oath","vow","pact","mirror"],
        nouns2: ["kings","seas","dawn","twilight","memory","dreams","silence","stones","blood","ancestors","children","forest","mountain","sky","night","day","wind","time","ages","shadows","heroes","villains"],
        adjectives: ["heavy","light","cold","warm","sharp","dull","bright","dim","secret","open","forgotten","remembered","cursed","blessed","tarnished","pure","sacred","profane","ancient","new","strong","weak","broken","whole","hidden"]
    ),

    // 15 (new)
    PhraseTemplate(
        structure: "carry the {adjective} {noun} to the {noun2}",
        nouns: ["torch","letter","token","coin","ring","seed","stone","egg","chalice","candle","mask","key","scroll","sigil","talisman","spear","leaf","feather","bone","ash"],
        nouns2: ["altar","door","gate","tower","harbor","island","forest","cave","well","crypt","throne","market","inn","temple","forge","library","vault","garden","crossroads","shrine"],
        adjectives: ["last","first","eternal","temporary","black","white","red","blue","golden","rusted","silent","noisy","cold","warm","wet","dry","hollow","full","tiny","giant"]
    ),

    // 16 (new)
    PhraseTemplate(
        structure: "they say the {noun} {verb} where the {noun2} {verb2}",
        nouns: ["wind","river","crow","wolf","owl","child","old woman","priest","merchant","thief","ghost","bell","song","songbird","ship","sail","star"],
        verbs: ["sleeps","wanders","cries","laughs","sings","weeps","hides","waits","watches","slinks","burns","fades","lingers","returns"],
        nouns2: ["stone","gate","door","mirror","well","sea","shore","forest","field","tower","city","village","graveyard","altar","crossroads"],
        verbs2: ["opens","closes","answers","asks","hums","rings","tolls","wakes","rests","breaks","holds","shifts"]
    ),

    // 17 (new)
    PhraseTemplate(
        structure: "a {adjective} {noun} {verb} in the {noun2}",
        nouns: ["boy","girl","dog","cat","lion","wolf","raven","crow","soldier","merchant","priest","seer","witch","wizard","child","stranger","mirror","stone","ring","child"],
        verbs: ["sleeps","dances","cries","laughs","wanders","runs","hides","dreams","wakes","breathes","whispers","sings","howls","calls","listens","sleeps"],
        nouns2: ["forest","city","ruin","shore","desert","cave","tower","temple","inn","garden","field","graveyard","market","hills","valley"],
        adjectives: ["lonely","restless","joyful","weary","hollow","golden","ashen","foolish","wise","wild","tame","strange","familiar","unknown","bright","dark","soft","hard","gentle","bruised"]
    ),

    // 18 (new)
    PhraseTemplate(
        structure: "remember {noun}, remember {noun2}, remember to {verb}",
        nouns: ["names","faces","songs","prayers","stories","maps","paths","stars","oaths","promises","troubles","joys","losses","gifts","debts","secrets","marks"],
        verbs: ["leave","return","speak","stay","go","wait","forget","remember","listen","heed","learn","teach","forgive","hide","open","close"],
        nouns2: ["scars","secrets","doors","keys","signs","symbols","riddles","dates","hours","names","voices","echoes","smiles","tears","wounds","flowers"]
    ),

    // 19 (new)
    PhraseTemplate(
        structure: "the {noun} that {verb} {preposition} the {adjective} {noun2}",
        nouns: ["stone","bird","child","ghost","man","woman","priest","thief","singer","merchant","river","wind","star","moon","sun","fox","hound","king","queen"],
        verbs: ["sleeps","rises","wanders","speaks","falls","weeps","shines","fades","passes","waits","lingers","screams","sings","whispers","breathes","shivers","melts","freezes"],
        nouns2: ["tree","door","gate","wall","mirror","well","altar","throne","shore","field","cave","tower","ruin","arch","bridge","labyrinth"],
        adjectives: ["ancient","young","broken","whole","silver","golden","black","white","shadowed","bright","quiet","loud","hollow","sacred","profane","forgotten"],
        preposition: ["beneath","above","beyond","within","between","upon","under","near","inside","outside","beside","through"]
    ),

    // 20 (new)
    PhraseTemplate(
        structure: "offer the {noun} and {noun2} to the {adjective} {noun3}",
        nouns: ["bread","wine","coin","song","word","promise","flower","seed","leaf","feather","stone","gem","candle","torch","letter","scent","salt","honey","milk","egg"],
        nouns2: ["name","memory","secret","riddle","song","story","tear","smile","sacrifice","oath","ring","talisman","spice","ink","timestamp","pact","vow","token","note","gland"],
        nouns3: ["altar","stone","sea","forest","oracle","spirit","god","goddess","king","queen","wood","well","market","threshold","gate","mirror","flame","grave","harbor","tower"],
        adjectives: ["silent","humming","ancient","young","jeweled","rusted","bloodstained","clean","tainted","bright","dark","holy","profane","hungry","sated","watchful","sleeping","awake","lonely","crowded"]
    )

]

    
    private let csvPhrases: [String] = {
        // Try to get CSV from framework bundle first
        if let frameworkBundle = Bundle(identifier: "com.oracleofnonsense.OracleSharedFramework.OracleSharedFramework"),
           let frameworkPath = frameworkBundle.path(forResource: "master", ofType: "csv"),
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
                "The oracle is silent today."
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
            let phrase = templates.randomElement()?.generatePhrase() ?? "The oracle is silent today."
            return GrammarCorrector.shared.correct(phrase)
        } else {
            return csvPhrases.randomElement() ?? "The oracle is silent today."
        }
    }
    
    // Widget-specific method that only uses CSV phrases
    public func generateWidgetPhrase() -> String {
        return csvPhrases.randomElement() ?? "The oracle is silent today."
    }
}

// MARK: - Grammar Corrector

public class GrammarCorrector {
    public static let shared = GrammarCorrector()
    
    private let tagger: NLTagger
    
    private init() {
        tagger = NLTagger(tagSchemes: [.lexicalClass, .nameType, .lemma, .nameTypeOrLexicalClass])
    }
    
    public func correct(_ text: String) -> String {
        var correctedText = text
        
        // Apply comprehensive grammar corrections in logical order
        correctedText = fixCapitalization(correctedText)
        correctedText = fixArticles(correctedText)
        correctedText = fixSubjectVerbAgreement(correctedText)
        correctedText = fixPronounAntecedentAgreement(correctedText)
        correctedText = fixVerbTenseConsistency(correctedText)
        correctedText = fixNounVerbAgreement(correctedText)
        correctedText = fixPrepositionUsage(correctedText)
        correctedText = fixPunctuation(correctedText)
        correctedText = fixWordChoice(correctedText)
        
        return correctedText
    }
    
    private func fixSubjectVerbAgreement(_ text: String) -> String {
        tagger.string = text
        var correctedText = text
        var tokens: [(String, NLTag, Range<String.Index>)] = []
        
        let options: NLTagger.Options = [.omitPunctuation, .omitWhitespace]
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .lexicalClass, options: options) { tag, tokenRange in
            if let tag = tag {
                let word = String(text[tokenRange])
                tokens.append((word, tag, tokenRange))
            }
            return true
        }
        
        // Enhanced subject-verb agreement checking
        for i in 0..<tokens.count - 1 {
            let (word, tag, range) = tokens[i]
            
            // Pattern 1: "the [noun] [verb]" - singular subject
            if tag == .determiner && word.lowercased() == "the" && i + 2 < tokens.count {
                let nounIndex = i + 1
                let verbIndex = i + 2
                
                if nounIndex < tokens.count && verbIndex < tokens.count {
                    let (noun, nounTag, _) = tokens[nounIndex]
                    let (verb, verbTag, verbRange) = tokens[verbIndex]
                    
                    if nounTag == .noun && verbTag == .verb {
                        let correctedVerb = makeVerbSingular(verb)
                        if correctedVerb != verb {
                            correctedText = correctedText.replacingOccurrences(of: verb, with: correctedVerb, options: .caseInsensitive)
                        }
                    }
                }
            }
            
            // Pattern 2: "[adjective] [noun] [verb]" - singular subject
            if tag == .adjective && i + 2 < tokens.count {
                let nounIndex = i + 1
                let verbIndex = i + 2
                
                if nounIndex < tokens.count && verbIndex < tokens.count {
                    let (noun, nounTag, _) = tokens[nounIndex]
                    let (verb, verbTag, verbRange) = tokens[verbIndex]
                    
                    if nounTag == .noun && verbTag == .verb {
                        let correctedVerb = makeVerbSingular(verb)
                        if correctedVerb != verb {
                            correctedText = correctedText.replacingOccurrences(of: verb, with: correctedVerb, options: .caseInsensitive)
                        }
                    }
                }
            }
            
            // Pattern 3: "a/an [noun] [verb]" - singular subject
            if (tag == .determiner && (word.lowercased() == "a" || word.lowercased() == "an")) && i + 2 < tokens.count {
                let nounIndex = i + 1
                let verbIndex = i + 2
                
                if nounIndex < tokens.count && verbIndex < tokens.count {
                    let (noun, nounTag, _) = tokens[nounIndex]
                    let (verb, verbTag, verbRange) = tokens[verbIndex]
                    
                    if nounTag == .noun && verbTag == .verb {
                        let correctedVerb = makeVerbSingular(verb)
                        if correctedVerb != verb {
                            correctedText = correctedText.replacingOccurrences(of: verb, with: correctedVerb, options: .caseInsensitive)
                        }
                    }
                }
            }
            
            // Pattern 4: "[noun] and [noun] [verb]" - plural subject
            if tag == .noun && i + 3 < tokens.count {
                let (conjunction, conjTag, _) = tokens[i + 1]
                let (noun2, noun2Tag, _) = tokens[i + 2]
                let (verb, verbTag, verbRange) = tokens[i + 3]
                
                if conjTag == .conjunction && conjunction.lowercased() == "and" && 
                   noun2Tag == .noun && verbTag == .verb {
                    let correctedVerb = makeVerbPlural(verb)
                    if correctedVerb != verb {
                        correctedText = correctedText.replacingOccurrences(of: verb, with: correctedVerb, options: .caseInsensitive)
                    }
                }
            }
        }
        
        return correctedText
    }
    
    private func makeVerbSingular(_ verb: String) -> String {
        let lowercasedVerb = verb.lowercased()
        
        // Handle common irregular verbs
        let irregularSingular: [String: String] = [
            "are": "is",
            "were": "was",
            "have": "has",
            "do": "does",
            "go": "goes",
            "say": "says",
            "get": "gets",
            "make": "makes",
            "take": "takes",
            "come": "comes",
            "see": "sees",
            "know": "knows",
            "think": "thinks",
            "look": "looks",
            "want": "wants",
            "give": "gives",
            "use": "uses",
            "find": "finds",
            "tell": "tells",
            "ask": "asks",
            "work": "works",
            "seem": "seems",
            "feel": "feels",
            "try": "tries",
            "leave": "leaves",
            "call": "calls",
            "move": "moves",
            "change": "changes",
            "turn": "turns",
            "start": "starts",
            "show": "shows",
            "hear": "hears",
            "play": "plays",
            "run": "runs",
            "bring": "brings",
            "write": "writes",
            "provide": "provides",
            "sit": "sits",
            "stand": "stands",
            "lose": "loses",
            "add": "adds",
            "become": "becomes",
            "remain": "remains"
        ]
        
        if let singular = irregularSingular[lowercasedVerb] {
            return capitalizeFirstLetter(singular, originalCase: verb)
        }
        
        // Handle regular verbs
        if lowercasedVerb.hasSuffix("ies") && lowercasedVerb.count > 3 {
            let stem = String(lowercasedVerb.dropLast(3))
            if !stem.isEmpty {
                return capitalizeFirstLetter(stem + "y", originalCase: verb)
            }
        } else if lowercasedVerb.hasSuffix("es") && lowercasedVerb.count > 2 {
            let stem = String(lowercasedVerb.dropLast(2))
            if !stem.isEmpty && (stem.hasSuffix("s") || stem.hasSuffix("sh") || stem.hasSuffix("ch") || stem.hasSuffix("x") || stem.hasSuffix("z")) {
                return capitalizeFirstLetter(lowercasedVerb, originalCase: verb)
            }
        } else if lowercasedVerb.hasSuffix("s") && lowercasedVerb.count > 1 {
            let stem = String(lowercasedVerb.dropLast(1))
            if !stem.isEmpty && !stem.hasSuffix("s") && !stem.hasSuffix("sh") && !stem.hasSuffix("ch") {
                return capitalizeFirstLetter(stem, originalCase: verb)
            }
        }
        
        return verb
    }
    
    private func makeVerbPlural(_ verb: String) -> String {
        let lowercasedVerb = verb.lowercased()
        
        // Handle common irregular verbs (plural forms)
        let irregularPlural: [String: String] = [
            "is": "are",
            "was": "were",
            "has": "have",
            "does": "do",
            "goes": "go",
            "says": "say",
            "gets": "get",
            "makes": "make",
            "takes": "take",
            "comes": "come",
            "sees": "see",
            "knows": "know",
            "thinks": "think",
            "looks": "look",
            "wants": "want",
            "gives": "give",
            "uses": "use",
            "finds": "find",
            "tells": "tell",
            "asks": "ask",
            "works": "work",
            "seems": "seem",
            "feels": "feel",
            "tries": "try",
            "leaves": "leave",
            "calls": "call",
            "moves": "move",
            "changes": "change",
            "turns": "turn",
            "starts": "start",
            "shows": "show",
            "hears": "hear",
            "plays": "play",
            "runs": "run",
            "brings": "bring",
            "writes": "write",
            "provides": "provide",
            "sits": "sit",
            "stands": "stand",
            "loses": "lose",
            "adds": "add",
            "becomes": "become",
            "remains": "remain"
        ]
        
        if let plural = irregularPlural[lowercasedVerb] {
            return capitalizeFirstLetter(plural, originalCase: verb)
        }
        
        // Handle regular verbs (remove 's' from end)
        if lowercasedVerb.hasSuffix("s") && lowercasedVerb.count > 1 {
            let stem = String(lowercasedVerb.dropLast(1))
            if !stem.isEmpty {
                return capitalizeFirstLetter(stem, originalCase: verb)
            }
        }
        
        return verb
    }
    
    private func fixArticles(_ text: String) -> String {
        var correctedText = text
        
        // Enhanced vowel detection using regex patterns
        let vowelPattern = #"\b(a)\s+([aeiouAEIOU])"#
        let consonantPattern = #"\b(an)\s+([bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ])"#
        
        // Fix "a" before vowels -> "an"
        correctedText = correctedText.replacingOccurrences(
            of: vowelPattern,
            with: "an $2",
            options: [.regularExpression, .caseInsensitive]
        )
        
        // Fix "an" before consonants -> "a" (but be careful with silent letters)
        correctedText = correctedText.replacingOccurrences(
            of: consonantPattern,
            with: "a $2",
            options: [.regularExpression, .caseInsensitive]
        )
        
        // Handle special cases where "an" is correct before consonants
        let silentConsonantWords = ["honor", "hour", "heir", "honest", "honorable"]
        for word in silentConsonantWords {
            let pattern = " a " + word
            let replacement = " an " + word
            correctedText = correctedText.replacingOccurrences(of: pattern, with: replacement, options: .caseInsensitive)
            
            let patternCap = " A " + word
            let replacementCap = " An " + word
            correctedText = correctedText.replacingOccurrences(of: patternCap, with: replacementCap, options: .caseInsensitive)
        }
        
        return correctedText
    }
    
    private func fixCapitalization(_ text: String) -> String {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return text }
        
        let firstChar = trimmedText.prefix(1).uppercased()
        let remainingText = trimmedText.dropFirst()
        
        if trimmedText.prefix(1) != firstChar {
            return firstChar + remainingText
        }
        
        return text
    }
    
    private func fixPunctuation(_ text: String) -> String {
        var correctedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Ensure sentence ends with proper punctuation
        if !correctedText.isEmpty && !correctedText.hasSuffix(".") && !correctedText.hasSuffix("!") && !correctedText.hasSuffix("?") {
            correctedText += "."
        }
        
        return correctedText
    }
    
    private func capitalizeFirstLetter(_ text: String, originalCase: String) -> String {
        guard !text.isEmpty else { return text }
        
        if originalCase.first?.isUppercase == true {
            return text.prefix(1).uppercased() + text.dropFirst()
        } else {
            return text
        }
    }
    
    // MARK: - Additional Grammar Correction Functions
    
    private func fixPronounAntecedentAgreement(_ text: String) -> String {
        var correctedText = text
        
        // Fix common pronoun-antecedent agreement issues
        let pronounCorrections: [(String, String)] = [
            ("they is", "they are"),
            ("they was", "they were"),
            ("they has", "they have"),
            ("they does", "they do"),
            ("we is", "we are"),
            ("we was", "we were"),
            ("we has", "we have"),
            ("we does", "we do"),
            ("you is", "you are"),
            ("you was", "you were"),
            ("you has", "you have"),
            ("you does", "you do")
        ]
        
        for (incorrect, correct) in pronounCorrections {
            correctedText = correctedText.replacingOccurrences(of: incorrect, with: correct, options: .caseInsensitive)
        }
        
        return correctedText
    }
    
    private func fixVerbTenseConsistency(_ text: String) -> String {
        var correctedText = text
        
        // Fix common tense inconsistencies
        let tenseCorrections: [(String, String)] = [
            ("was go", "was going"),
            ("was come", "was coming"),
            ("was take", "was taking"),
            ("was make", "was making"),
            ("was see", "was seeing"),
            ("was know", "was knowing"),
            ("was think", "was thinking"),
            ("was look", "was looking"),
            ("was want", "was wanting"),
            ("was give", "was giving"),
            ("was use", "was using"),
            ("was find", "was finding"),
            ("was tell", "was telling"),
            ("was ask", "was asking"),
            ("was work", "was working"),
            ("was seem", "was seeming"),
            ("was feel", "was feeling"),
            ("was try", "was trying"),
            ("was leave", "was leaving"),
            ("was call", "was calling"),
            ("was move", "was moving"),
            ("was change", "was changing"),
            ("was turn", "was turning"),
            ("was start", "was starting"),
            ("was show", "was showing"),
            ("was hear", "was hearing"),
            ("was play", "was playing"),
            ("was run", "was running"),
            ("was bring", "was bringing"),
            ("was write", "was writing")
        ]
        
        for (incorrect, correct) in tenseCorrections {
            correctedText = correctedText.replacingOccurrences(of: incorrect, with: correct, options: .caseInsensitive)
        }
        
        return correctedText
    }
    
    private func fixNounVerbAgreement(_ text: String) -> String {
        var correctedText = text
        
        // Fix common noun-verb agreement issues
        let agreementCorrections: [(String, String)] = [
            ("nouns is", "nouns are"),
            ("nouns was", "nouns were"),
            ("nouns has", "nouns have"),
            ("nouns does", "nouns do"),
            ("words is", "words are"),
            ("words was", "words were"),
            ("words has", "words have"),
            ("words does", "words do"),
            ("things is", "things are"),
            ("things was", "things were"),
            ("things has", "things have"),
            ("things does", "things do"),
            ("stars is", "stars are"),
            ("stars was", "stars were"),
            ("stars has", "stars have"),
            ("stars does", "stars do"),
            ("stones is", "stones are"),
            ("stones was", "stones were"),
            ("stones has", "stones have"),
            ("stones does", "stones do")
        ]
        
        for (incorrect, correct) in agreementCorrections {
            correctedText = correctedText.replacingOccurrences(of: incorrect, with: correct, options: .caseInsensitive)
        }
        
        return correctedText
    }
    
    private func fixPrepositionUsage(_ text: String) -> String {
        var correctedText = text
        
        // Fix common preposition errors
        let prepositionCorrections: [(String, String)] = [
            ("in the between", "between"),
            ("on the between", "between"),
            ("at the between", "between"),
            ("in the inside", "inside"),
            ("on the outside", "outside"),
            ("at the outside", "outside"),
            ("in the within", "within"),
            ("on the within", "within"),
            ("at the within", "within"),
            ("in the beneath", "beneath"),
            ("on the beneath", "beneath"),
            ("at the beneath", "beneath"),
            ("in the above", "above"),
            ("on the above", "above"),
            ("at the above", "above"),
            ("in the beyond", "beyond"),
            ("on the beyond", "beyond"),
            ("at the beyond", "beyond")
        ]
        
        for (incorrect, correct) in prepositionCorrections {
            correctedText = correctedText.replacingOccurrences(of: incorrect, with: correct, options: .caseInsensitive)
        }
        
        return correctedText
    }
    
    private func fixWordChoice(_ text: String) -> String {
        var correctedText = text
        
        // Fix common word choice errors and improve clarity
        let wordChoiceCorrections: [(String, String)] = [
            ("it's", "its"),  // possessive vs contraction context dependent
            ("there going", "they're going"),
            ("there here", "they're here"),
            ("there coming", "they're coming"),
            ("there waiting", "they're waiting"),
            ("your welcome", "you're welcome"),
            ("your going", "you're going"),
            ("your coming", "you're coming"),
            ("your waiting", "you're waiting"),
            ("loose", "lose"),  // context dependent, but common error
            ("loosing", "losing"),
            ("definately", "definitely"),
            ("seperate", "separate"),
            ("occured", "occurred"),
            ("occuring", "occurring"),
            ("begining", "beginning"),
            ("comming", "coming"),
            ("writting", "writing"),
            ("runing", "running"),
            ("swiming", "swimming"),
            ("stoping", "stopping"),
            ("geting", "getting"),
            ("puting", "putting"),
            ("siting", "sitting"),
            ("hiting", "hitting"),
            ("cuting", "cutting"),
            ("shuting", "shutting")
        ]
        
        for (incorrect, correct) in wordChoiceCorrections {
            correctedText = correctedText.replacingOccurrences(of: incorrect, with: correct, options: .caseInsensitive)
        }
        
        return correctedText
    }
}
