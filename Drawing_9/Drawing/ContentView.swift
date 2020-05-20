//
//  ContentView.swift
//  Drawing
//
//  Created by Toshiki Ichibangase on 2020/05/02.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width/2 - insetAmount , startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: clockwise)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct Flower: Shape {
    var petalOffset: Double = -20
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {
            let rotation = CGAffineTransform(rotationAngle: number)
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width/2, y: rect.height/2))
            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width/2))
            let rotatedPetal = originalPetal.applying(position)
            
            path.addPath(rotatedPetal)
        }
        
        return path
    }
}

struct Trapezoid: Shape {
    var insetAmount: CGFloat
    var animatableData: CGFloat {
        get { insetAmount }
        set { self.insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0 ,y: rect.maxY))
        
        return path
    }
}

struct Arrow: Shape {
    
    var barWidth: CGFloat
    var animatableData: CGFloat {
        get { barWidth }
        set { self.barWidth = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.midY - barWidth))
        path.addLine(to: CGPoint(x: rect.maxX * 2/3, y: rect.midY - barWidth))
        path.addLine(to: CGPoint(x: rect.maxX * 2/3, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX * 2/3, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX * 2/3, y: rect.midY + barWidth))
        path.addLine(to: CGPoint(x: 0, y: rect.midY + barWidth))
        
        path.addLine(to: CGPoint(x: 0, y: rect.midY - barWidth))
        
        return path
    }
}


struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 50
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 50
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    @State private var colorCycle = 0.0
    @State private var amount: CGFloat = 0.0
    @State private var insetAmount: CGFloat = 50
    @State private var barWidth: CGFloat = 10
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 50) {
                VStack {
                    ColorCyclingRectangle(amount: self.colorCycle)
                        .frame(width: 200, height: 200)
                    
                    Slider(value: $colorCycle)
                }
                
                VStack {
                    Button("Reset") {
                        withAnimation {
                            self.barWidth = 10
                        }
                    }
                    
                    Arrow(barWidth: barWidth)
                        .frame(width: 200, height: barWidth*6)
                        .foregroundColor(Color.blue)
                        .onTapGesture {
                            withAnimation {
                                self.barWidth += 10
                            }
                        }
                }
                
                Trapezoid(insetAmount: insetAmount)
                    .frame(width: 200, height: 100)
                    .foregroundColor(Color.green)
                    .onTapGesture {
                        withAnimation {
                            self.insetAmount = CGFloat.random(in: 1..<100)
                        }
                    }
                
                Image("cat_mike")
                    .resizable()
                    .scaledToFit()
                    .saturation(Double(amount))
                    .blur(radius: (1 - amount) * 20)
                
                Slider(value: $amount)
                
                VStack {
                    ZStack {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 200 * amount)
                            .offset(x: -50, y: -80)
                            .blendMode(.screen)
                        
                        Circle()
                            .fill(Color.green)
                            .frame(width: 200 * amount)
                            .offset(x: 50, y: -80)
                            .blendMode(.screen)
                        
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 200 * amount)
                            .blendMode(.screen)
                    }
                    .frame(width: 200, height: 200)
                    
                    Slider(value: $amount)
                }
                .frame(height: 500)
                .background(Color.black)
                
                ZStack {
                    Image("cat_mike")
                        .resizable()
                        .frame(width: 200, height: 200)
                    
                    Rectangle()
                        .fill(Color.green)
                        .blendMode(.multiply)
                }
                .frame(width:  200, height: 200)
                .clipped()
                
                VStack {
                    ColorCyclingCircle(amount: self.colorCycle)
                        .frame(width: 200, height: 200)
                    
                    Slider(value: $colorCycle)
                }
                
                Group {
                    Text("Hello, world!")
                        .frame(width: 200, height: 200)
                        .border(ImagePaint(image: Image("cat_mike"),scale: 0.1),width: 30)
                    
                    Triangle()
                        .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                        .frame(width: 200, height: 180)
                    
                    Arc(startAngle: .degrees(0), endAngle: .degrees(200), clockwise: true)
                        .strokeBorder(Color.blue, lineWidth: 10)
                        .frame(width: 200, height: 200)
                    
                    VStack {
                        Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                            .fill(Color.red, style: FillStyle(eoFill: true))
                            .frame(width: 200, height: 200)
                        
                        Text("Offset")
                        Slider(value: $petalOffset, in: -40...40)
                            .padding([.horizontal,.bottom])
                        
                        Text("Width")
                        Slider(value: $petalWidth, in: 0...100)
                            .padding(.horizontal)
                    }
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
