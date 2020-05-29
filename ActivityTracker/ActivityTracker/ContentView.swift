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
                    VStack(alignment: .leading) {
                        Text(user.logData[0].category)
                            .font(.largeTitle)
                            .padding(.horizontal)
                            .offset(x: 0, y: 30)
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(0 ..< user.logData.count) { num in
                                    NavigationLink(destination:
                                        DetailView(user: self.user, dataNumber: num)
                                    ) {
                                        LineCardView(dataName: self.user.logData[num].logName, dataset: self.dataSet(dataNumber: num))
                                            .environment(\.colorScheme, .light)
                                            .frame(width: 180, height: 250)
                                            .padding(5)
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationBarTitle("\(user.name)'s Activity")
                
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
                        .padding()
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddActivity) {
            AddActivityView()
        }
    }
    
    func dataSet(dataNumber: Int) -> [[Double]] {
        var dataset = [[Double]]()
        let logData = user.logData[dataNumber]
        
        for data in logData.data {
            dataset.append(data.datum)
        }
        
        return dataset
        //return [[0.0,0.0], [1.0, 2.0]]
    }
    
    init() {
        user.logData.append(UserInformation.LogData())
        user.logData[0].logName = "Example 1"
        
        var exampleData = user.logData[0]
        var date = Date()
        exampleData.data.append(UserInformation.LogData.Data())
        exampleData.data[0].datum = [0.0, 0.0]
        exampleData.data[0].date = date
        
        date = date.addingTimeInterval(86400)
        exampleData.data.append(UserInformation.LogData.Data())
        exampleData.data[1].date = date
        exampleData.data[1].datum = [1.0, 2.0]
        
        date = date.addingTimeInterval(86400)
        exampleData.data.append(UserInformation.LogData.Data())
        exampleData.data[2].date = date
        exampleData.data[2].datum = [2.0, 5.0]
        
        date = date.addingTimeInterval(86400)
        exampleData.data.append(UserInformation.LogData.Data())
        exampleData.data[3].date = date
        exampleData.data[3].datum = [3.0, -2.0]
        
        date = date.addingTimeInterval(86400)
        exampleData.data.append(UserInformation.LogData.Data())
        exampleData.data[4].date = date
        exampleData.data[4].datum = [4.0, 1.0]
        
        user.logData.append(UserInformation.LogData())
        user.logData[1].logName = "Example 2"
        
        exampleData = user.logData[1]
        date = Date()
        exampleData.data.append(UserInformation.LogData.Data())
        exampleData.data[0].datum = [0.0, 0.0]
        exampleData.data[0].date = date
        
        date = date.addingTimeInterval(86400)
        exampleData.data.append(UserInformation.LogData.Data())
        exampleData.data[1].date = date
        exampleData.data[1].datum = [1.0, 5.0]
        
        date = date.addingTimeInterval(86400)
        exampleData.data.append(UserInformation.LogData.Data())
        exampleData.data[2].date = date
        exampleData.data[2].datum = [2.0, 3.0]
        
        date = date.addingTimeInterval(86400)
        exampleData.data.append(UserInformation.LogData.Data())
        exampleData.data[3].date = date
        exampleData.data[3].datum = [3.0, 1.0]
        
        date = date.addingTimeInterval(86400)
        exampleData.data.append(UserInformation.LogData.Data())
        exampleData.data[4].date = date
        exampleData.data[4].datum = [4.0, 4.0]
        
        user.logData.append(UserInformation.LogData())
        user.logData[2].logName = "Example 3"
        
        exampleData = user.logData[2]
        date = Date()
        exampleData.data.append(UserInformation.LogData.Data())
        exampleData.data[0].datum = [0.0, 0.0]
        exampleData.data[0].date = date
        
        date = date.addingTimeInterval(86400)
        exampleData.data.append(UserInformation.LogData.Data())
        exampleData.data[1].date = date
        exampleData.data[1].datum = [1.0, 5.0]
        
        date = date.addingTimeInterval(86400)
        exampleData.data.append(UserInformation.LogData.Data())
        exampleData.data[2].date = date
        exampleData.data[2].datum = [2.0, 3.0]
        
        date = date.addingTimeInterval(86400)
        exampleData.data.append(UserInformation.LogData.Data())
        exampleData.data[3].date = date
        exampleData.data[3].datum = [3.0, 1.0]
        
        date = date.addingTimeInterval(86400)
        exampleData.data.append(UserInformation.LogData.Data())
        exampleData.data[4].date = date
        exampleData.data[4].datum = [4.0, 4.0]
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
