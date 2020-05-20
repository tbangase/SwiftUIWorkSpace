//
//  ContentView.swift
//  WordScramble
//
//  Created by Toshiki Ichibangase on 2020/04/25.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var isShowingError = false
    
    @State private var score = 0
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word.", text: $newWord,onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                Text("Your current score is \(score)")
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(trailing:
                Button(action: startGame) {
                    Text("=> New Game")
            })
            .onAppear(perform: startGame)
            .alert(isPresented: $isShowingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        guard isEnoughLong(word: answer) else {
            wordError(title: "Word is too short", message: "Use 4 or more characters!")
            newWord = ""
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more creative!")
            newWord = ""
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You're too creative! So you use letter not exsists! haha >V<")
            newWord = ""
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "Did you make yor own word? That's nice! But in this game, not :-(")
            newWord = ""
            return
        }
        
        score += Int(pow(Double(answer.count),2.0))
        
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "silkworm"
                return
            }
        }
        
        fatalError("start.txt file cannot load from bundle.")
    }
    
    func isEnoughLong(word: String) -> Bool {
        //3文字以上入力されているかどうか判断する
        if word.count < 4 {
            return false
        }
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        //唯一の言葉かどうか判断する
        if word == rootWord {
            return false
        }
        
        return !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        //ルートワードに含まれている文字で作っているかどうか判断する
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
        //その単語が存在するかどうか判断する
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        isShowingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
