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
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(.vertical) {
                    ForEach(0..<user.info.categories.count) { num in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(self.user.info.categories[num])
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .padding(.horizontal)
                                    .offset(x: 0, y: 20)
                                
                                Spacer()
                            }
                            
                            
                            if self.categoryMatched(category: self.user.info.categories[num]).isEmpty{
                                Text("No Activity yet.")
                                    .font(.largeTitle)
                                    .foregroundColor(.secondary)
                                    .padding()
                            } else {
                                ScrollView(.horizontal) {
                                    HStack {
                                        ForEach(0 ..< self.user.info.logData.count) { num in
                                            NavigationLink(destination:
                                                DetailView(user: self.user, dataNumber: num)
                                            ) {
                                                LineCardView(dataName: self.user.info.logData[num].logName, dataset: self.dataSet(dataNumber: num))
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
                        .clipShape(Circle())
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
    
    init() {
        user.info.logData.append(UserData.LogData())
        user.info.logData[0].logName = "Example 1"
        
        var exampleData = user.info.logData[0]
        exampleData.category = "Health"
        
        var date = Date()
        exampleData.data.append(UserData.LogData.Data())
        exampleData.data[0].datum = [0.0, 0.0]
        exampleData.data[0].date = date
        
        
        date = date.addingTimeInterval(86400)
        exampleData.data.append(UserData.LogData.Data())
        exampleData.data[1].date = date
        exampleData.data[1].datum = [1.0, 2.0]
        
        date = date.addingTimeInterval(86400)
        exampleData.data.append(UserData.LogData.Data())
        exampleData.data[2].date = date
        exampleData.data[2].datum = [2.0, 5.0]
        
        date = date.addingTimeInterval(86400)
        exampleData.data.append(UserData.LogData.Data())
        exampleData.data[3].date = date
        exampleData.data[3].datum = [3.0, -2.0]
        
        date = date.addingTimeInterval(86400)
        exampleData.data.append(UserData.LogData.Data())
        exampleData.data[4].date = date
        exampleData.data[4].datum = [4.0, 1.0]
        
        user.info.logData.append(UserData.LogData())
        user.info.logData[1].logName = "Example 2"
        
        exampleData = user.info.logData[1]
        exampleData.category = "Ambition"
        date = Date()
        exampleData.data.append(UserData.LogData.Data())
        exampleData.data[0].datum = [0.0, 0.0]
        exampleData.data[0].date = date
        
        date = date.addingTimeInterval(86400)
        exampleData.data.append(UserData.LogData.Data())
        exampleData.data[1].date = date
        exampleData.data[1].datum = [1.0, 5.0]
        
        date = date.addingTimeInterval(86400)
        exampleData.data.append(UserData.LogData.Data())
        exampleData.data[2].date = date
        exampleData.data[2].datum = [2.0, 3.0]
        
        date = date.addingTimeInterval(86400)
        exampleData.data.append(UserData.LogData.Data())
        exampleData.data[3].date = date
        exampleData.data[3].datum = [3.0, 1.0]
        
        date = date.addingTimeInterval(86400)
        exampleData.data.append(UserData.LogData.Data())
        exampleData.data[4].date = date
        exampleData.data[4].datum = [4.0, 4.0]
        
        user.info.logData.append(UserData.LogData())
        user.info.logData[2].logName = "Example 3"
        
        exampleData = user.info.logData[2]
        exampleData.category = "Relation"
        
        date = Date()
        exampleData.data.append(UserData.LogData.Data())
        exampleData.data[0].datum = [0.0, 0.0]
        exampleData.data[0].date = date
        
        date = date.addingTimeInterval(86400)
        exampleData.data.append(UserData.LogData.Data())
        exampleData.data[1].date = date
        exampleData.data[1].datum = [1.0, 5.0]
        
        date = date.addingTimeInterval(86400)
        exampleData.data.append(UserData.LogData.Data())
        exampleData.data[2].date = date
        exampleData.data[2].datum = [2.0, 3.0]
        
        date = date.addingTimeInterval(86400)
        exampleData.data.append(UserData.LogData.Data())
        exampleData.data[3].date = date
        exampleData.data[3].datum = [3.0, 1.0]
        
        date = date.addingTimeInterval(86400)
        exampleData.data.append(UserData.LogData.Data())
        exampleData.data[4].date = date
        exampleData.data[4].datum = [4.0, 4.0]
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
