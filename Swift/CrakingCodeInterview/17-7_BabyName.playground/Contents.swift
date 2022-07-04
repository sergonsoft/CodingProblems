/**
 Problem: Baby Names
 Each year, the government releases a list of the 10000 most common baby names and their frequencies {the number of babies with that name). The only problem with this is that some names have multiple spellings. For example, "John" and "Jon" are essentially the same name but would be listed separately in the list. Given two lists, one of names/frequencies and the other of pairs of equivalent names, write an atgorithm to print a new list of the true frequency of each name. Note that if John and Jon are synonyms, and Jon and Johnny are synonyms, then John and Johnny are synonyms, (it is both transitive and symmetric.) In the final list, any name can be used as the "real" name,
 
 EXAMPLE
 Input:
 Names: John (15), Jon (12), Chris (13), Kris (4), Christopher (19)
 Synonyms: (Jon, John), (John, Johnny), (Chris, Kris), {Chris, Christopher)
 
 Output:
 John (27), Kris (36)
*/

/*
 ********* Functions *************
 */

import Foundation.NSString

func parseSynonyms(_ s:String) -> [(String, String)] {
    var result:[(String, String)] = []

    let r =
        s.index(after:s.firstIndex(of: "(")!)
        ..<
        s.lastIndex(of: ")")!
    
    for synonyms in String(s[r]).components(separatedBy: "), (") {
        let syn = synonyms.components(separatedBy: ", ")
        result.append((syn[0], syn[1]))
    }
    
    return result
}

func mergeSynonyms(_ names:[(String, String)]) -> [Set<String>] {
    var synonyms: [Set<String>] = []
    
    for n in names {
        var added = false
        for i in 0..<synonyms.count {
            if synonyms[i].contains(n.0) {
                synonyms[i].insert(n.1)
                added = true
                break
            }
            
            if synonyms[i].contains(n.1) {
                synonyms[i].insert(n.0)

                added = true
                break
            }

        }
        if !added {
            synonyms.append([n.0, n.1])
        }
    }
    
    return synonyms
}

func reduceSynonyms(_ raw_synonyms:[Set<String>]) -> [Set<String>] {
    var reducedSynonyms:[Set<String>] = []
    
    for raw_synonym in raw_synonyms {
        var merged = false
        
        for i in 0..<reducedSynonyms.count {
            if !reducedSynonyms[i].intersection(raw_synonym).isEmpty {
                reducedSynonyms[i].formUnion(raw_synonym)
                merged = true
            }
        }
        
        if !merged {
            reducedSynonyms.append(raw_synonym)
        }
    }
    
    return reducedSynonyms
}

typealias NameFrequency = (name:String, frequency:Int)

func parseNames(from names:String) -> [NameFrequency] {
    var a:[NameFrequency] = []
    
    for n in names.components(separatedBy: ", ") {
        let t = String(n).components(separatedBy: " (")
        a.append((t[0], Int( String(t[1].dropLast()) )! ))
    }
    
    return a
}

func prepareResults(_ synonyms_frequency:[Set<String>:Int]) -> [(String, Int)] {
    var result: [(String, Int)] = []
    
    for s in synonyms_frequency.keys {
        result.append((s[s.startIndex], synonyms_frequency[s]!))
    }
    
    return result
}

func countName(names: [NameFrequency], synonyms:[Set<String>]) -> [Set<String>:Int] {
    var nc:[Set<String>:Int] = [:]

    for s in synonyms {
        for name in names {
            if s.contains(name.name) {
                if nc.keys.contains(s) {
                    nc.updateValue(nc[s]! + name.frequency, forKey: s)
                }
                else {
                    nc[s] = name.frequency
                }
            }
        }
    }
    return nc
}


/*
 *********** Testing functions *************
 */
func compareResults(lhs:[NameFrequency], rhs:[NameFrequency], in synonyms:[Set<String>]) -> Bool {
    guard lhs.count == rhs.count else {
        return false
    }
    
    var matchesCount: Int = 0
    
    for lhn in lhs {
        if let s = getSetOfSynonyms(forName:lhn.name) {
            var rhn:NameFrequency?
            for n in rhs {
                if s.contains(n.name) {
                    rhn = n
                    break
                }
            }
            if let rhn = rhn {
                if lhn.frequency == rhn.frequency {
                    matchesCount += 1
                }
                else {
                    print("Count for matched name \(lhn.name) isn't equals. \(lhn.frequency) and \(rhn.frequency) accordingly.")
                    return false
                }
            }
            else {
                print("The is not matchnig for the name \(lhn.name)")
                return false
            }
        }
        else {
            print("There is no set of synonyms that contains results name: \(lhn.name)")
            return false
        }
    }
    
    if lhs.count != matchesCount {
        print("Found names are not equal matches: \(lhs.count) and \(matchesCount)")
        return false
    }
    
    return true
}

func getSetOfSynonyms(forName name:String) -> Set<String>? {
    for s in synonyms {
        if s.contains(name) {
            return s
        }
    }
    
    return nil
}


/* *********************************************************
 *  Solution
 * ******************************************************* */

let input_names = "John (15), Jon (12), Chris (13), Kris (4), Christopher (19)"
let input_synonyms = "(Jon, John), (John, Johnny), (Chris, Kris), (Chris, Christopher)"
let expected_output:[NameFrequency] = [ ("John", 27), ("Kris", 36) ]


let synonyms_pairs = parseSynonyms(input_synonyms)
let synonyms = reduceSynonyms(mergeSynonyms(synonyms_pairs))
let name_frequency = parseNames(from: input_names)
var names_counted = countName(names: name_frequency, synonyms:synonyms)

print("Name & synonyms frequesncy: \(names_counted)")

let result = prepareResults(names_counted)
print("Results to assert: \(result)")
assert(compareResults(lhs:result, rhs:expected_output, in:synonyms))

print("Solved!!!!")

