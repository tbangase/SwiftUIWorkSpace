//
//  LineChartView.swift
//  Tabbed_app_test
//
//  Created by Toshiki Ichibangase on 2020/05/21.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct LineCardView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var sampleData = [[Double]]()
    var sampleData2 = [[Double]]()
    
    let offset: CGFloat = 20
    let cardHeight: CGFloat = 200
    var body: some View {
        GeometryReader { geo in
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: geo.size.width/2 - self.offset*2,
                               height: self.cardHeight)
                        .foregroundColor(self.colorScheme == .dark ? .black : .white)
                        .padding(self.offset)
                        .shadow(color: self.colorScheme == .dark ? Color.blue : Color.gray, radius: 10)
                    
                    VStack {
                        HStack {
                            Text("Heart Rate")
                                .font(.title)
                            Spacer()
                        }.padding(.leading)
                        Spacer()
                    }.frame(width: geo.size.width/2 - self.offset*2,
                            height: self.cardHeight - 30)
                    
                    LineChartView(dataSet: self.sampleData)
                        .frame(width: geo.size.width/2 - self.offset*2,
                               height: self.cardHeight - 70)
                        .offset(x: 0, y: 20)
                }.offset(x:0/*self.offset/4*/, y:0)
            }
        }
        .background(colorScheme == .dark ? Color.black : Color.white)
        .edgesIgnoringSafeArea(.all)
    
    }
    
    init() {
        for i in 0..<10 {
            sampleData.append([Double(i), Double.random(in: 0...10)])
            sampleData2.append([Double(i), Double.random(in: 0...10)])
        }
    }
}

struct LineCardView_Previews: PreviewProvider {
    static var previews: some View {
        LineCardView()
            .environment(\.colorScheme, .dark)
    }
}
