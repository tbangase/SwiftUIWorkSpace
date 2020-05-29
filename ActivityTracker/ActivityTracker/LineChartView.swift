//
//  LineView.swift
//  Tabbed_app_test
//
//  Created by Toshiki Ichibangase on 2020/05/21.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct LinePath: Shape {
    let dataSet: [[Double]]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let fixedData = fixedDataSet(dataSet: dataSet)
        var currentData = fixedData[0]
        var lastData = fixedData[0]
        
        let maxWidth = widthDifference(dataSet: dataSet)
        let maxHeight = heightDifference(dataSet: dataSet)
        
        let offset = heightOffset(dataSet: dataSet)
        
        path.move(to: CGPoint(x: rect.maxX * CGFloat(currentData[0] / maxWidth),
                              y: rect.maxY * CGFloat((currentData[1] + offset) / maxHeight)))
        
        for i in 1..<dataSet.count {
            currentData = fixedData[i]
            
            let centerX = (currentData[0] + lastData[0]) / 2
            let centerY = (currentData[1] + lastData[1]) / 2
            
            let controlX_1 = (lastData[0] + centerX) / 2
            let controlY_1 = lastData[1]
            
            let controlX_2 = (currentData[0] + centerX) / 2
            let controlY_2 = currentData[1]
            /*path.addLine(to: CGPoint(x: rect.maxX * CGFloat(currentData[0] /                                maxWidth),
                                     y: rect.maxY * CGFloat((currentData[1] + offset) / maxHeight)))*/
            path.addQuadCurve(to: CGPoint(x: rect.maxX * CGFloat(centerX /                                maxWidth),
                                          y: rect.maxY * CGFloat((centerY + offset) / maxHeight)),
                              control: CGPoint(x: rect.maxX * CGFloat(controlX_1 /                                maxWidth),
                                               y: rect.maxY * CGFloat((controlY_1 + offset) / maxHeight)))
            path.addQuadCurve(to: CGPoint(x: rect.maxX * CGFloat(currentData[0] /                                maxWidth),
                                          y: rect.maxY * CGFloat((currentData[1] + offset) / maxHeight)),
                              control: CGPoint(x: rect.maxX * CGFloat(controlX_2 /                                maxWidth),
                                               y: rect.maxY * CGFloat((controlY_2 + offset) / maxHeight)))
            lastData = currentData
        }
        
        return path
    }
    
    func widthDifference(dataSet: [[Double]]) -> Double {
        var max = 0.0
        var min = 0.0
        
        for i in 0..<dataSet.count {
            if max < dataSet[i][0] {
                max = dataSet[i][0]
            }
            
            if min > dataSet[i][0] {
                min = dataSet[i][0]
            }
        }
        
        return max - min
        
    }
    
    
    func heightDifference(dataSet: [[Double]]) -> Double {
        var max = 0.0
        var min = 0.0
        
        for i in 0..<dataSet.count {
            if max < dataSet[i][1] {
                max = dataSet[i][1]
            }
            
            if min > dataSet[i][1] {
                min = dataSet[i][1]
            }
        }
        
        return max - min
    }
    
    func heightOffset(dataSet: [[Double]]) -> Double {
        var min = 0.0
        
        for i in 0..<dataSet.count {
            if min > dataSet[i][1] {
                min = dataSet[i][1]
            }
        }
        
        return min
    }
    
    func fixedDataSet(dataSet: [[Double]]) -> [[Double]] {
        var reversed = [[Double]]()
        
        let maxHeight = heightDifference(dataSet: dataSet)
        
        
        for i in 0..<dataSet.count {
            reversed.append([dataSet[i][0], maxHeight - dataSet[i][1]])
        }
        
        return reversed
    }
}

struct LineChartView: View {
    @State private var showLine = false
    
    let dataSet: [[Double]]
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                if self.dataSet.isEmpty {
                    Text("No data").font(.title)
                } else {
                    LinePath(dataSet: self.dataSet)
                        .trim(from: 0, to: self.showLine ? 1 : 0)
                        .stroke(Color.green , lineWidth: 5)
                        .onAppear(perform: {
                            withAnimation(.easeInOut(duration: 2)) {
                                self.showLine = true
                            }
                        })
                }
                
                /*Button("Animate") {
                    withAnimation(.easeInOut(duration: 2)) {
                        self.showLine.toggle()
                    }
                }*/
            }
            .contentShape(Rectangle())
            /*.onTapGesture {
                self.showLine = false
                withAnimation(.easeInOut(duration: 2)) {
                    self.showLine = true
                }
            }*/
        }
        
        
        
    }
}

struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
        var sampleData = [[Double]]()
        
        for i in 0..<30 {
            sampleData.append([Double(i), Double.random(in: 0...10)])
        }
        
        return LineChartView(dataSet: sampleData)
            .frame(width: 300, height: 200)
    }
}
