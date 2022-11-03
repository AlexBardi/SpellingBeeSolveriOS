//
//  LetterForm.swift
//  SpellingBeeSolver
//
//  Created by Alex Bardi on 11/2/22.
//

import SwiftUI

struct LetterForm: View {
    @State var centerLetter = ""
    @State var otherLetters = ""
    @State var showSolutions = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("What is the center letter?")
                TextField("sdf", text: $centerLetter)
                Text("What are the other letters?")
                TextField("sdf", text: $otherLetters)
                NavigationLink {
                    SolutionScreen(centerLetter: centerLetter, otherLetters: otherLetters)
                } label: {
                    Text("Solver")
                }
            }
            
        }
    }
}

struct LetterForm_Previews: PreviewProvider {
    static var previews: some View {
        LetterForm()
    }
}
