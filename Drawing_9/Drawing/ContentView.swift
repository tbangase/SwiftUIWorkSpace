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

struct  CheckerBoard: Shape {
    var rows: Int
    var columns: Int
    
    public var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(columns))
        }
        
        set {
            self.rows = Int(newValue.first)
            self.columns = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowSize = rect.height / CGFloat(rows)
        let columnSize = rect.width / CGFloat(columns)
        
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                    let startX = columnSize * CGFloat(column)
                    let startY = rowSize * CGFloat(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        return path
    }
}

struct Spirograph: Shape {
    let innerRadius: Int
    let outerRadius: Int
    let distance: Int
    let amount: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let divisor = gcd(innerRadius, outerRadius)
        let outerRadius = CGFloat(self.outerRadius)
        let innerRadius = CGFloat(self.innerRadius)
        let distance = CGFloat(self.distance)
        let difference = innerRadius - outerRadius
        let endPoint = ceil(2 * CGFloat.pi * outerRadius / CGFloat(divisor)) * amount
        
        var path = Path()
        
        for theta in stride(from: 0, to: endPoint, by: 0.01) {
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)

            x += rect.width / 2
            y += rect.height / 2

            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        return path
    }
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b
        
        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }
        
        return a
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
    
    @State private var rows = 2
    @State private var columns = 2
    
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var distance = 25.0
    @State private var spiroAmount: CGFloat = 1.0
    @State private var hue = 0.6
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 50) {
                VStack {
                    HStack {
                        ColorCyclingRectangle(amount: self.colorCycle)
                            .frame(width: 100, height: 100)
                        
                        ColorCyclingRectangle(amount: self.colorCycle)
                        .frame(width: 100, height: 100)
                    }
                    HStack {
                        ColorCyclingRectangle(amount: self.colorCycle)
                            .frame(width: 100, height: 100)
                        
                        ColorCyclingRectangle(amount: self.colorCycle)
                        .frame(width: 100, height: 100)
                    }
                    
                    Slider(value: $colorCycle)
                }
                
                VStack {
                    Arrow(barWidth: barWidth)
                        .stroke(style: StrokeStyle(lineWidth: barWidth, lineCap: .round, lineJoin: .round))
                        .frame(width: 200, height: barWidth*6)
                        .foregroundColor(Color.blue)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                self.barWidth += 10
                            }
                        }
                    
                    Button("Reset") {
                        withAnimation {
                            self.barWidth = 10
                        }
                    }.padding()
                }
                
                VStack(spacing: 20) {
                    Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: spiroAmount)
                        .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
                        .frame(width: 300, height: 300)
                    
                    Group {
                        Text("Inner radius: \(Int(innerRadius))")
                        Slider(value: $innerRadius, in: 10...150, step: 1)
                            .padding([.horizontal, .bottom])

                        Text("Outer radius: \(Int(outerRadius))")
                        Slider(value: $outerRadius, in: 10...150, step: 1)
                            .padding([.horizontal, .bottom])

                        Text("Distance: \(Int(distance))")
                        Slider(value: $distance, in: 1...150, step: 1)
                            .padding([.horizontal, .bottom])

                        Text("Amount: \(amount, specifier: "%.2f")")
                        Slider(value: $amount)
                            .padding([.horizontal, .bottom])

                        Text("Color")
                        Slider(value: $hue)
                            .padding(.horizontal)
                    }
                }
                
                Group {
                    CheckerBoard(rows: rows, columns: columns)
                        .onTapGesture {
                            withAnimation(.linear(duration: 0.5)) {
                                self.rows += 4
                                self.columns += 4
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
                        
                }
                
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
                            //.stroke(Color.red, lineWidth: 1)
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
