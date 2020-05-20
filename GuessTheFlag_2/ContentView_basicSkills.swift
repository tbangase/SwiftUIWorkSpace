//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Toshiki Ichibangase on 2020/04/21.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            VStack {
                LinearGradient(gradient: Gradient(colors: [.white, .red,.green, .blue, .black]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
                RadialGradient(gradient: Gradient(colors: [.white,.blue, .black]), center: .center, startRadius: 20, endRadius: 200)
                AngularGradient(gradient: Gradient(colors: [.red, .yellow,.green,.blue,.purple,.red]), center: .center)
            }
            Color.red.frame(width: 150, height: 120)
            VStack {
                Text("Hello, World!")
                Button(action: {
                    print("Button tapped!")
                }) {
                    HStack {
                        Image(systemName: "pencil")
                        Text("Edit")
                    }
                }
                Button("Showing Alert") {
                    self.showAlert = true
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Hello SwiftUI!"), message: Text("This is some detail message"), dismissButton: .default(Text("OK")))
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
