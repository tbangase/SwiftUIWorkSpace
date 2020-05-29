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
    
    var dataName: String
    
    var dataset: [[Double]]
    
    let offset: CGFloat = 20
    let cardHeight: CGFloat = 200
    var body: some View {
        GeometryReader { geo in
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: geo.size.width - self.offset,
                               height: self.cardHeight)
                        .foregroundColor(self.colorScheme == .dark ? .black : .white)
                        .padding(self.offset)
                        .shadow(color: self.colorScheme == .dark ? Color.blue : Color.gray, radius: 5, x: 3, y: 3)
                    
                    VStack {
                        HStack {
                            Text(self.dataName)
                                .font(.title)
                            Spacer()
                        }.padding(.leading)
                        Spacer()
                    }.frame(width: geo.size.width - self.offset,
                            height: self.cardHeight - 30)
                    
                    LineChartView(dataSet: self.dataset)
                        .frame(width: geo.size.width - self.offset,
                               height: self.cardHeight - 70)
                        .offset(x: 0, y: 20)
                }.offset(x:0/*self.offset/4*/, y:0)
            }
        }
        .background(colorScheme == .dark ? Color.black : Color.white)
        .edgesIgnoringSafeArea(.all)
    
    }
    
}

struct LineCardView_Previews: PreviewProvider {
    static var previews: some View {
        var data = [[Double]]()
        for i in 0..<10 {
            data.append([Double(i), Double.random(in: 0...10)])
        }
        
        return LineCardView(dataName: "Example", dataset: data)
            .environment(\.colorScheme, .dark)
    }
}
