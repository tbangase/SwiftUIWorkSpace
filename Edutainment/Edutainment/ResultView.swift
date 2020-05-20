//
//  ResultView.swift
//  Edutainment
//
//  Created by Toshiki Ichibangase on 2020/05/17.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct ResultView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var env: gameEnvironment
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("Result")
                    .font(.largeTitle)
                    .padding(5)
                    .frame(width: geo.size.width, alignment: .leading)
                
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: geo.size.width, height: 3)
                    .offset(x: 0,y: -20)
                
                Spacer()
                
                HStack {
                    Image("\(self.env.correctCount / 10)")
                        .resizable()
                        .frame(width: 150, height: 150)
                    Image("\(self.env.correctCount % 10)")
                        .resizable()
                        .frame(width: 150, height: 150)
                    
                }
                
                Rectangle()
                    .frame(width: geo.size.width - 50, height: 10)
                    .foregroundColor(.blue)
                
                HStack {
                    Image("\(self.env.questionNumber / 10)")
                        .resizable()
                        .frame(width: 150, height: 150)
                    Image("\(self.env.questionNumber % 10)")
                        .resizable()
                        .frame(width: 150, height: 150)
                    
                }
                
                Spacer()
                
                Button(action: {
                    self.env.gameActive = false
                    self.env.questionCount = 1
                    self.env.correctCount = 0
                    self.env.allCombination = [[Int]]()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("One More?")
                        .font(.title)
                        .foregroundColor(Color.white)
                        .frame(width: 300, height: 70)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: Color.gray, radius: 5, x: 3, y: 3)
                }
                
                Spacer()
            }
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(env: gameEnvironment())
    }
}
