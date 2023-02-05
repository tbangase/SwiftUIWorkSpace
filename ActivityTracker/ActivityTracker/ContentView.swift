//
//  ContentView.swift
//  ActivityTracker
//
//  Created by Toshiki Ichibangase on 2020/05/29.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var user = UserInformation()
    
    @State private var showingAddActivity = false
    @State var needReflesh = false
    
    var matchedCategories = [String]()
    var matchedIds = [Int]()
    
    var body: some View {
        NavigationView {
            ZStack {
                /*VStack {
                    HStack{
                        Spacer()
                        
                        Button("Debug") {
                            self.debug()
                        }.padding()
                    }
                    Spacer()
                }*/
                
                ScrollView(.vertical) {
                    ForEach(user.info.categories, id: \.self) { category in
                        VStack(alignment: .leading) {
                            if !self.categoryMatched(category: category).isEmpty {
                                HStack {
                                    Text(category)
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .padding(.horizontal)
                                        .offset(x: 0, y: 20)
                                    
                                    Spacer()
                                }
                                
                                
                                if self.categoryMatched(category: category).isEmpty{
                                    Text("No Activity yet.")
                                        .font(.largeTitle)
                                        .foregroundColor(.secondary)
                                        .padding()
                                } else {
                                    ScrollView(.horizontal) {
                                        HStack {
                                            ForEach(0 ..< self.categoryMatched(category: category).count, id: \.self) { num in
                                                NavigationLink(destination:
                                                    DetailView(user: self.user,
                                                               dataNumber: self.matchedId(category: category)[num], needReflesh: Binding<Bool>(get: {self.needReflesh}, set: { newValue in
                                                                self.needReflesh = newValue
                                                               }))
                                                ) {
                                                    LineCardView(dataName: self.categoryMatched(category: category)[num].logName, dataset: self.dataSet(dataNumber: self.matchedId(category: category)[num]))
                                                        .environment(\.colorScheme, .light)
                                                        .frame(width: 150, height: 180)
                                                        .padding(5)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationBarTitle("\(user.info.name)'s Activity")
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            self.showingAddActivity = true
                        }) {
                            Image(systemName: "pencil")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                        }
                        .frame(width: 70, height: 70)
                        .background(Color.blue)
                        .clipShape(Rectangle())
                        .buttonStyle(PlainButtonStyle())
                        .shadow(radius: 5,x: 5,y: 5)
                        .padding()
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddActivity) {
            AddActivityView(user: self.user)
        }
    }
    
    func dataSet(dataNumber: Int) -> [[Double]] {
        var dataset = [[Double]]()
        let logData = user.info.logData[dataNumber]
        
        for data in logData.data {
            dataset.append(data.datum)
        }
        
        return dataset
        //return [[0.0,0.0], [1.0, 2.0]]
    }
    
    func categoryMatched(category: String) -> [UserData.LogData] {
        var matched = [UserData.LogData]()
        
        if user.info.logData.isEmpty { return matched }
        
        for logdata in user.info.logData {
            if logdata.category == category {
                matched.append(logdata)
            }
        }
        
        return matched
    }
    
    func matchedId(category: String) -> [Int] {
        var ids = [Int]()
        
        if user.info.logData.isEmpty { return ids }
        
        for num in 0..<user.info.logData.count {
            if user.info.logData[num].category == category {
                ids.append(num)
            }
        }
        
        return ids
    }
    
    func debug() {
        print(user.info.logData)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
