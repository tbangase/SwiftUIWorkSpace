//
//  ContentView.swift
//  ViewAndModifiers
//
//  Created by Toshiki Ichibangase on 2020/04/22.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

struct WaterMark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    func watermarked(with text:String) -> some View {
        self.modifier(WaterMark(text: text))
    }
}

struct BlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.blue)
            .font(.largeTitle)
        
    }
}

extension View {
    func blueTitle() -> some View {
        self.modifier(BlueTitle())
    }
}



struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
    
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content ) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("ViewAndModifier")
                .blueTitle()
            Spacer()
            Text("Hello, world!")
                .titleStyle()
            Color.blue
                .frame(width:200, height: 200)
                .watermarked(with: "watermark.swift")
            GridStack(rows: 4, columns: 4) {row, column in
                    Spacer()
                    Text("\(row) - \(column)")
                    Spacer()
            }
            .frame(width:300, height: 200)
        
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


