//
//  ContentView.swift
//  Edutainment
//
//  Created by Toshiki Ichibangase on 2020/05/17.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

class gameEnvironment: ObservableObject {
    @Published var tableSize = 9
    @Published var questionNumber = 10
    @Published var allQuestion = false
    
    @Published var gameActive = false
    
    @Published var allCombination = [[Int]]()
    @Published var currentCombination = [Int]()
    
    @Published var questionCount = 1
    @Published var correctCount = 0
}

struct ContentView: View {
    
    @ObservedObject var env = gameEnvironment()
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 20) {
                if self.env.gameActive {
                    GameRunningView(env: self.env)
                } else {
                    GameSettingView(env: self.env)
                }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
