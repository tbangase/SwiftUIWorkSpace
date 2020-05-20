//
//  ContentView.swift
//  Moonshot
//
//  Created by Toshiki Ichibangase on 2020/04/29.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "pencil")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<10) {
                        Text("Text \($0)")
                    }
                }
                .frame(height: 50)
            }
            
            Spacer()
            
            NavigationView {
                VStack {
                    NavigationLink(destination: Text("DetailView")) {
                        Text("Hello, world")
                    }
                    
                    NavigationView {
                        List(0..<10) { row in
                            NavigationLink(destination: Text("DetailView\(row)")) {
                                Text("Hello, smallworld \(row)!")
                            }
                        }
                    .navigationBarTitle("swiftui")
                    }
                    .frame(height: 200)
                }
                .navigationBarTitle("SwiftUI")
            }
            .frame(height: 350)
            
            Spacer()
            
            Button("JSON Decoder") {
                let input = """
                {
                    "name": "Taylor Swift",
                    "adress": {
                        "street": "555, Taylor Swift Avenue",
                        "city": "Nashville"
                    }
                }
                """
                
                struct User: Codable {
                    var name: String
                    var adress: Adress
                }
                
                struct Adress: Codable {
                    var street: String
                    var city: String
                }
                
                let data = Data(input.utf8)
                let decoder = JSONDecoder()
                if let user = try? decoder.decode(User.self,from: data) {
                    print(user.adress.street)
                    print(user.adress.city)
                }
            }
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
