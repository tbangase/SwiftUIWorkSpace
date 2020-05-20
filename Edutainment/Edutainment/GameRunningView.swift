//
//  GameRunningView.swift
//  Edutainment
//
//  Created by Toshiki Ichibangase on 2020/05/17.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct GameRunningView: View {
    @ObservedObject var env: gameEnvironment
    
    @State private var answer = 0
    @State private var answertText = ""
    
    @State private var isShowResult = false
    
    let buttonWidth: CGFloat = 70
    let buttonHeight: CGFloat = 70
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 20) {
                HStack {
                    Text("What is the answer ??")
                        .font(.title)
                        .padding(5)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("\(self.env.questionCount) / \(self.env.questionNumber)")
                        .font(.title)
                        .padding(5)
                        .foregroundColor(.white)
                }
                .frame(width: geo.size.width, alignment: .leading)
                .background(Color.blue)
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .foregroundColor(Color(red: 0.6, green: 0.8, blue: 1))
                        .padding(5)
                        .frame(width: geo.size.width, height: 160)
                        .offset(x: 0, y: -10)
                        
                    
                    
                    HStack {
                        Image(String(self.env.currentCombination[0]))
                            .resizable()
                            .frame(width: 100, height: 120)
                            .offset(x: 0, y: -20)
                        
                        Image("multiply")
                            .resizable()
                            .frame(width: 80, height: 80)
                        
                        Image(String(self.env.currentCombination[1]))
                            .resizable()
                            .frame(width: 100, height: 120)
                            .offset(x: 0, y: -20)
                    }
                    
                }
                
                ZStack {
                    Group {
                        Image("A")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }.frame(width: geo.size.width, alignment: .leading)
                    
                    Text("\(self.answer)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                }
                .padding(5)
                .frame(width: geo.size.width)
                .background(Color(red: 0.3, green: 0.3, blue: 0.3))
                
                
                Group {
                    VStack {
                        HStack {
                            Button(action: {
                                self.answertText.append("1")
                                self.answer = Int(self.answertText) ?? 0
                            }) {
                                Image("1")
                                    .resizable()
                                    .frame(width:self.buttonWidth, height: self.buttonHeight)
                            }
                            
                            Button(action: {
                                self.answertText.append("2")
                                self.answer = Int(self.answertText) ?? 0
                            }) {
                                Image("2")
                                    .resizable()
                                    .frame(width:self.buttonWidth, height: self.buttonHeight)
                            }
                            
                            Button(action: {
                                self.answertText.append("3")
                                self.answer = Int(self.answertText) ?? 0
                            }) {
                                Image("3")
                                    .resizable()
                                    .frame(width:self.buttonWidth, height: self.buttonHeight)
                            }
                        }
                        
                        HStack {
                            Button(action: {
                                self.answertText.append("4")
                                self.answer = Int(self.answertText) ?? 0
                            }) {
                                Image("4")
                                    .resizable()
                                    .frame(width:self.buttonWidth, height: self.buttonHeight)
                            }
                            
                            Button(action: {
                                self.answertText.append("5")
                                self.answer = Int(self.answertText) ?? 0
                            }) {
                                Image("5")
                                    .resizable()
                                    .frame(width:self.buttonWidth, height: self.buttonHeight)
                            }
                            
                            Button(action: {
                                self.answertText.append("6")
                                self.answer = Int(self.answertText) ?? 0
                            }) {
                                Image("6")
                                    .resizable()
                                    .frame(width:self.buttonWidth, height: self.buttonHeight)
                            }
                        }
                        
                        HStack {
                            Button(action: {
                                self.answertText.append("7")
                                self.answer = Int(self.answertText) ?? 0
                            }) {
                                Image("7")
                                    .resizable()
                                    .frame(width:self.buttonWidth, height: self.buttonHeight)
                            }
                            
                            Button(action: {
                                self.answertText.append("8")
                                self.answer = Int(self.answertText) ?? 0
                            }) {
                                Image("8")
                                    .resizable()
                                    .frame(width:self.buttonWidth, height: self.buttonHeight)
                            }
                            
                            Button(action: {
                                self.answertText.append("9")
                                self.answer = Int(self.answertText) ?? 0
                            }) {
                                Image("9")
                                    .resizable()
                                    .frame(width:self.buttonWidth, height: self.buttonHeight)
                            }
                        }
                        
                        HStack {
                            Button(action: {
                                self.answertText = ""
                                self.answer = 0
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.gray)
                                        .frame(width: self.buttonWidth, height: self.buttonHeight)
                                        .offset(x: 0, y: 3)
                                    
                                    Image("c")
                                        .resizable()
                                        .frame(width:self.buttonWidth, height: self.buttonHeight)
                                }
                            }
                            
                            Button(action: {
                                self.answertText.append("0")
                                self.answer = Int(self.answertText) ?? 0
                            }) {
                                Image("0")
                                    .resizable()
                                    .frame(width:self.buttonWidth, height: self.buttonHeight)
                            }
                            
                            
                            Button(action: {
                                self.judgeAnswer()
                                
                                if self.env.questionCount == self.env.questionNumber {
                                    self.isShowResult = true
                                }
                                
                                self.newQuestion()
                                self.env.questionCount += 1
                            }) {
                                Image("go")
                                    .resizable()
                                    .frame(width: self.buttonWidth, height: self.buttonHeight)
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .sheet(isPresented: $isShowResult) {
            ResultView(env: self.env)
        }
    }
    
    func judgeAnswer() {
        let correctAnswer = env.currentCombination[0] * env.currentCombination[1]
        
        if correctAnswer == self.answer {
            env.correctCount += 1
        } else {
            // action when answer is incorrect
        }
    }
    
    func newQuestion() {
        if env.questionCount == env.questionNumber { return }
        
        env.currentCombination = env.allCombination[env.questionCount]
        
        answer = 0
        answertText = ""
    }
}

struct GameRunningView_Previews: PreviewProvider {
    static var previews: some View {
        let env = gameEnvironment()
        
        env.allCombination = [[7,8],[1,2],[3,4],[5,6],[9,10],
                              [11,12],[3,5],[2,8],[7,4],[8,3]]
        env.currentCombination = env.allCombination[0]
        
        return GameRunningView(env: env)
    }
}
