//
//  GameSettingView.swift
//  Edutainment
//
//  Created by Toshiki Ichibangase on 2020/05/17.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct GameSettingView: View {
    @ObservedObject var env: gameEnvironment
    
    @State private var opacity5: Double = 1.0
    @State private var opacity10: Double = 1.0
    @State private var opacity20: Double = 1.0
    @State private var opacityAll: Double = 1.0
    
    @State private var offset5x: CGFloat = 0.0
    @State private var offset5y: CGFloat = 0.0
    @State private var offset10x: CGFloat = 0.0
    @State private var offset10y: CGFloat = 0.0
    @State private var offset20x: CGFloat = 0.0
    @State private var offset20y: CGFloat = 0.0
    @State private var offsetAllx: CGFloat = 0.0
    @State private var offsetAlly: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 20) {
                Text("New Game")
                    .font(.title)
                    .padding(3)
                    .frame(width: geo.size.width, alignment: .leading)
                
                Rectangle()
                    .frame(width: geo.size.width, height: 3)
                    .foregroundColor(.blue)
                    .offset(x: 0, y: -25)
                
                Spacer()
                
                Text("Select Multiple Table Size!")
                    .font(.headline)
                    .padding([.leading,.trailing])
                    .frame(width: geo.size.width, alignment: .leading)
                Picker(selection: self.$env.tableSize, label: Text("Picker")) {
                    ForEach(2..<10, id:\.self) {
                        Text("\($0) × \($0) Table")
                            .font(.system(.headline , design: .monospaced))
                    }
                }.labelsHidden()
                
                /*Stepper(value: self.$env.tableSize, in: 1...12) {
                    HStack{
                        Text("Choose table size: ")
                            .font(.headline)
                        Spacer()
                        
                        Text("\(self.env.tableSize)")
                            .font(.headline)
                    }
                    .padding()
                }*/
                
                Text("START GAME with question num of ...")
                    .font(.headline)
                    .padding(5)
                    .frame(width: geo.size.width, alignment: .leading)
                    .background(Color.blue)
                    .foregroundColor(.white)
                
                HStack{
                    Spacer()
                    Button(action: {
                        self.env.questionNumber = 5
                        self.makeCombinations()
                        withAnimation {
                            self.opacity10 = 0.0
                            self.opacity20 = 0.0
                            self.opacityAll = 0.0
                            self.offset5x = geo.size.width/4 - 5
                            self.offset5y = 40
                        }
                        withAnimation(Animation.easeInOut.delay(3)) {
                            self.env.gameActive = true
                        }
                    }) {
                        Text("5")
                            .font(.title)
                            .foregroundColor(Color.white)
                            .frame(width: 150, height: 70)
                            .background(Color.green)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: Color.gray, radius: 5, x: 3, y: 3)
                            .opacity(self.opacity5)
                            .offset(x: self.offset5x, y: self.offset5y)
                    }
                    
                    
                    Spacer()
                    
                    Button(action: {
                        self.env.questionNumber = 10
                        self.makeCombinations()
                        withAnimation {
                            self.opacity5 = 0.0
                            self.opacity20 = 0.0
                            self.opacityAll = 0.0
                            self.offset10x = 5 - geo.size.width/4
                            self.offset10y = 40
                        }
                        withAnimation(Animation.easeInOut.delay(3)) {
                            self.env.gameActive = true
                        }
                    }) {
                        Text("10")
                            .font(.title)
                            .foregroundColor(Color.white)
                            .frame(width: 150, height: 70)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: Color.gray, radius: 5, x: 3, y: 3)
                            .opacity(self.opacity10)
                            .offset(x: self.offset10x, y: self.offset10y)
                    }
                    
                    
                    Spacer()
                }
                
                HStack{
                    Spacer()
                    Button(action: {
                        self.env.questionNumber = 20
                        self.makeCombinations()
                        withAnimation {
                            self.opacity5 = 0.0
                            self.opacity10 = 0.0
                            self.opacityAll = 0.0
                            self.offset20x = geo.size.width/4 - 5
                            self.offset20y = 0 - 40
                        }
                        withAnimation(Animation.easeInOut.delay(3)) {
                            self.env.gameActive = true
                        }
                    }) {
                        Text("20")
                            .font(.title)
                            .foregroundColor(Color.white)
                            .frame(width: 150, height: 70)
                            .background(Color.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: Color.gray, radius: 5, x: 3, y: 3)
                            .opacity(self.opacity20)
                            .offset(x: self.offset20x, y: self.offset20y)
                    }
                    
                    
                    Spacer()
                    
                    Button(action: {
                        self.env.questionNumber = self.env.tableSize * (self.env.tableSize - 1) / 2 + self.env.tableSize
                        self.makeCombinations()
                        withAnimation {
                            self.opacity5 = 0.0
                            self.opacity10 = 0.0
                            self.opacity20 = 0.0
                            self.offsetAllx = 5 - geo.size.width/4
                            self.offsetAlly = 0 - 40
                        }
                        withAnimation(Animation.easeInOut.delay(3)) {
                            self.env.gameActive = true
                        }
                    }) {
                        Text("ALL")
                            .font(.title)
                            .foregroundColor(Color.white)
                            .frame(width: 150, height: 70)
                            .background(Color.red)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: Color.gray, radius: 5, x: 3, y: 3)
                            .opacity(self.opacityAll)
                            .offset(x: self.offsetAllx, y: self.offsetAlly)
                    }
                    
                    
                    Spacer()
                }.padding(.bottom)
            }
        }
    }
    
    func makeCombinations() {
        var newCombination = [0,0]
        
        let possible = env.tableSize * (env.tableSize - 1) / 2 + env.tableSize
        
        if env.questionNumber > possible {
            env.questionNumber = possible
        }
        
        for _ in 0..<env.questionNumber {
            
            while !combinationValidation(used: env.allCombination,new: newCombination) {
                newCombination[0] = Int.random(in: 1..<env.tableSize+1)
                newCombination[1] = Int.random(in: 1..<env.tableSize+1)
            }
            
            
            env.allCombination.append(newCombination)
        }
        
        
        env.currentCombination = env.allCombination[0]
    }
    
    func combinationValidation(used: [[Int]], new: [Int]) -> Bool {
        if new == [0,0] {
            return false
        }
        
        if used.count == 0 {
            return true
        } else {
            for num in 0..<used.count {
                if used[num] == new {
                    return false
                } else if used[num][0] == new[1] && used[num][1] == new[0] {
                    return false
                }
            }
        }
        
        return true
    }
}

struct GameSettingView_Previews: PreviewProvider {
    static var previews: some View {
        GameSettingView(env: gameEnvironment())
    }
}
