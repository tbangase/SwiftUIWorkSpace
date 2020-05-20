//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Toshiki Ichibangase on 2020/04/21.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var totalScore = 0
    @State private var flagNumber = 0
    
    @State private var animationSpinDegree = [Double](repeating: 0.0, count: 3)
    @State private var flagOpacity = [Double](repeating: 1.0, count: 3)
    @State private var fadeOutAmount = CGSize.zero
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, .blue, .black]), startPoint: .topTrailing, endPoint: .bottomLeading).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.blue)
                    Text("\(countries[correctAnswer])")
                        .foregroundColor(.blue)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        withAnimation {
                            if number == self.correctAnswer {
                                self.animationSpinDegree[number] += 360
                            } else {
                                self.flagOpacity[number] = 0.0
                            }
                            for i in 0..<3 {
                                if i != number { self.flagOpacity[i] = 0.25 }
                            }
                        }
                        self.flagTapped(number)
                    }) {
                        FlagImage(image: Image(self.countries[number]))
                            .opacity(self.flagOpacity[number])
                            .rotation3DEffect(.degrees(self.animationSpinDegree[number]), axis: (x:0, y:1, z:0))
                            .offset(self.fadeOutAmount)
                    }
                    
                }
                
                VStack {
                    Text("Your current score is")
                        .foregroundColor(.white)
                    Text("\(totalScore)")
                        .foregroundColor(.white)
                        .font(.title)
                }
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("This is the flag of \(countries[flagNumber]).\nYour current score is \(totalScore)"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                for i in 0..<self.flagOpacity.count {
                        self.flagOpacity[i] = 1.0
                    }
                })
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!!"
            totalScore += 10
        } else {
            scoreTitle = "Wrong..."
            totalScore -= 5
        }
        showingScore = true
        flagNumber = number
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct FlagImage: View {
    var image: Image
    
    var body: some View {
        image
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black,lineWidth: 1))
            .shadow(color: .black, radius: 10)
    }
}
/*
extension Image {
    func flagImage() -> some View {
        self
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black,lineWidth: 1))
            .shadow(color: .black, radius: 10)
    }
}
*/
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
