//
//  SolutionScreen.swift
//  SpellingBeeSolver
//
//  Created by Alex Bardi on 11/2/22.
//

import SwiftUI

struct SolutionScreen: View {
    let centerLetter: String
    let otherLetters: String
    
    @State var panagrams: [String] = []
    @State var solutions: [Int: [String]] = [:]
    @State var keys: [Int] = []
    
    var body: some View {
        List {
            Section {
                List(panagrams, id: \.self) {panagram in
                    Text(panagram)
                }
            } header: {
                Text("Panagrams")
                    .bold()
            }
            ForEach(keys, id: \.self) { key in
                Section {
                    ForEach(solutions[key] ?? [], id: \.self) { word in
                        Text(word)
                    }
                } header: {
                    Text(String(key))
                        .bold()
                }
            }
        }
        .task {
            findSolutions()
        }
    }
    
    func getKeys() -> [Int] {
        return solutions.keys.sorted()
    }
    
    func findSolutions() {
        let goodLetters = Set(otherLetters.lowercased()[...] + centerLetter.lowercased()[...])
        let allWords = getWords()
        
        for word in allWords {
            let wordLetters = Set(word.lowercased())
            if (wordLetters == goodLetters) {
                panagrams.append(word)
            } else if (wordLetters.isSubset(of: goodLetters)) && (word.count >= 4) {
                if solutions[word.count] != nil {
                    solutions[word.count]?.append(word)
                } else {
                    solutions[word.count] = [word]
                }
            }
        }
        let unsortedKeys = solutions.compactMap {
            $0.key
        }
        keys = unsortedKeys.sorted().reversed()
    }
    
    func getWords() -> Array<String> {
        if let filepath = Bundle.main.path(forResource: "englishDictionary.csv", ofType: nil) {
            do {
                let content = try String(contentsOfFile: filepath)
                let parsedCSV: [String] = content.components(
                    separatedBy: "\n"
                ).map{ $0.components(separatedBy: ",")[0] }
                return parsedCSV
            }
            catch {
                dump(error)
                return []
            }
        }
        return []
    }
}



struct SolutionScreen_Previews: PreviewProvider {
    static var previews: some View {
        SolutionScreen(centerLetter: "c", otherLetters: "lwiatd")
    }
}
