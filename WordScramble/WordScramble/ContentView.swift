//
//  ContentView.swift
//  WordScramble
//
//  Created by Pranav on 14/07/25.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var newWord = ""
    @State private var rootWord = "kokoroto"
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Enter your word", text: $newWord)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .padding()
                    .onSubmit {
                        addNewWord()
                        newWord = ""
                    }
                
                List {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .toolbar {
                ToolbarItem {
                    Button("Restart", action: startGame)
                }
            }
            
        }
        .onAppear(perform: startGame)
        .alert(errorTitle, isPresented: $showingError) {
            Button("OK") { }
        } message: {
            Text(errorMessage)
        }
       
    }
    
    // MARK: - Error Alert
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    // MARK: - Word Checkers
    func isOriginal(_ word: String) -> Bool {
        !usedWords.contains(word.lowercased())
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en"
        )
        
        return misspelledRange.location == NSNotFound
    }
    
    // MARK: - Add Word Logic
    func addNewWord() {
        let answer = newWord
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 2 else { return } // ignore tiny words
        
        guard isOriginal(answer) else {
            wordError(title: "Word used already", message: "Be more original.")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
    }
    
    // MARK: - Load Root Word
    func startGame() {
        if let startURL = Bundle.main.url(forResource: "start", withExtension: "txt"),
           let startContents = try? String(contentsOf: startURL) {
            let allWords = startContents.components(separatedBy: "\n")
                .filter { $0.count == 8 }
            
            rootWord = allWords.randomElement() ?? "kokoroto"
            usedWords = []
        } else {
            fatalError("❌ Could not load start.txt from bundle.")
        }
    }
}

#Preview {
    ContentView()
}
