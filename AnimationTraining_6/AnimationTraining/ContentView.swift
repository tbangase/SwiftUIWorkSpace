//
//  ContentView.swift
//  AnimationTraining
//
//  Created by Toshiki Ichibangase on 2020/04/26.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView: View {
    @State private var animationAmount = 0.0
    @State private var animationIntAmount: CGFloat = 1
    
    @State private var dragAmount = CGSize.zero
    @State private var textDragAmount = CGSize.zero
    
    @State private var enabled = false
    
    @State private var strokeAmount: CGFloat = 1
    
    let letters = Array("Hello, world!")
    
    
    
    var body: some View {
        VStack {
            Stepper("Size of circle is \(animationIntAmount, specifier: "%g")", value: $animationIntAmount.animation(
                Animation.easeInOut(duration: 1)
            ), in: 1...10)
            
            Spacer()
            
            Button("Tap Me") {
                withAnimation(.interpolatingSpring(stiffness: 50, damping: 10)) {
                    self.animationAmount += 360
                }
            }
            .padding(50)
            .background(Color.red)
            .foregroundColor(Color.white)
            .clipShape(Circle())
            .scaleEffect(animationIntAmount)
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
            .overlay(
                Circle()
                    .stroke(Color.red)
                    .scaleEffect(strokeAmount)
                    .opacity(Double(2 - strokeAmount))
                    .animation(
                        Animation.easeOut(duration: 1)
                            .repeatForever(autoreverses: false)
                    )
            )
            .onAppear(perform: {
                self.strokeAmount += 1
            })
            
            Spacer()
            
            LinearGradient(gradient: Gradient(colors: [.yellow,.red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 300, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(dragAmount)
                .gesture(
                    DragGesture()
                        .onChanged { self.dragAmount = $0.translation }
                        .onEnded() { _ in
                            withAnimation(.spring()) {
                                self.dragAmount = .zero
                            }
                        }
                )
            
            Spacer()
            
            HStack(spacing: 0) {
                ForEach(0..<letters.count) { num in
                    Text(String(self.letters[num]))
                        .padding(1)
                        .font(.title)
                        .background(self.enabled ? Color.red : Color.blue)
                        .foregroundColor(Color.white)
                        .offset(self.textDragAmount)
                        .animation(Animation.default.delay(Double(num)/20))
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { self.textDragAmount = $0.translation }
                    .onEnded { _ in
                        self.textDragAmount = .zero
                        self.enabled.toggle()
                }
            )
            
            Spacer()
            
            VStack{
                Button("Tap here") {
                    withAnimation{
                        self.enabled.toggle()
                    }
                }
                .font(.title)
                
                if enabled {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 200, height: 200)
                        .transition(.pivot)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
