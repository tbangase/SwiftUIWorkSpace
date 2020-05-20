//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Toshiki Ichibangase on 2020/05/07.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    static let choice = ["rock", "paper", "scissor"]
    
    @State private var appChoice = Int.random(in: 0..<choice.count)
    @State private var winGame = Bool.random()
    
    @State private var myChoice = 0
    @State private var score = 0
    @State private var questionCount = 0
    
    @State private var continuousCollect = 0
    
    @State private var resultTitle = ""
    @State private var resultMessage = ""
    @State private var showResult = false
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 20) {
                
                Text("Question \(self.questionCount + 1) / 10")
                    .padding()
                    .frame(width: geo.size.width, alignment: .leading)
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                /*Text("Your score is : \(self.score)")
                    .font(.largeTitle)*/
                Spacer()
                Image(Self.choice[self.appChoice])
                    .resizable()
                    .frame(width: 200, height: 200)
                Text("Choose: \(self.winGame ? "Win": "Lose")")
                    .font(.title)
                
                /*Button("Reset") {
                    self.appChoice = Int.random(in: 0..<Self.choice.count)
                    self.winGame = Bool.random()
                }*/
                Spacer()
                
                
                Text("Choose your HAND")
                    .frame(width: geo.size.width, alignment: .leading)
                    .padding(3)
                    .font(.headline)
                    .foregroundColor(.white)
                    .background(Color.blue)
                
                HStack {
                    ForEach(0..<Self.choice.count) { number in
                        Button(action: {
                            self.myChoice = number
                            self.JudgeChoice()
                        }) {
                            Image(Self.choice[number])
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.bottom)
            }
        }
        .alert(isPresented: $showResult) {
            Alert(title: Text(resultTitle), message: Text(resultMessage), dismissButton: .default(Text("Next")))
        }
    }
    
    func JudgeChoice() {
        if CollectChoice() == myChoice {
            score += 10 + continuousCollect * 2
        } else {
            score -= 5
            continuousCollect = 0
        }
        
        appChoice = Int.random(in: 0..<Self.choice.count)
        winGame = Bool.random()
        
        questionCount += 1
        
        if questionCount == 10 {
            showResult = true
            resultTitle = "Total Score"
            resultMessage = """
                Your total score is \(score).
                Well done!
            """
            
            score = 0
            questionCount = 0
        }
    }
    
    func CollectChoice() -> Int {
        if winGame == true {
            if appChoice == 2 {
                return 0
            } else {
                return appChoice + 1
            }
        } else {
            if appChoice == 0 {
                return 2
            } else {
                return appChoice - 1
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
