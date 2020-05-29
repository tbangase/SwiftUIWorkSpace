//
//  DetailView.swift
//  ActivityTracker
//
//  Created by Toshiki Ichibangase on 2020/05/29.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var user: UserInformation
    
    @State private var showingAddData = false
    
    let dataNumber: Int
    //var dataset: [[Double]]
    
    var body: some View {
        ZStack {
            LineChartView(dataSet: dataSet())
                .frame(width: 300, height: 200)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.showingAddData = true
                    }) {
                        Text("Add Data")
                            .font(.title)
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .buttonStyle(PlainButtonStyle())
                    .padding()
                }
            }
        }
        .sheet(isPresented: $showingAddData) {
            AddDataView()
        }
        .navigationBarTitle(user.logData[dataNumber].logName)
    }
    
    func dataSet() -> [[Double]] {
        var dataset = [[Double]]()
        let logData = user.logData[dataNumber]
        
        for data in logData.data {
            dataset.append(data.datum)
        }
        
        return dataset
        //return [[0.0,0.0], [1.0, 2.0]]
    }
    
    /*
    init(user: UserInformation){
        self.user = user
        self.dataNumber = 0
        self.dataset = [[Double]]()
        
        let logData = user.logData[dataNumber]
        
        for data in logData.data {
            self.dataset.append(data.datum)
        }
    }*/
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let user = UserInformation()
        user.logData.append(UserInformation.LogData())
        user.logData[0].logName = "Log Name"
        
        
        var date = Date()
        user.logData[0].data.append(UserInformation.LogData.Data())
        user.logData[0].data[0].date = date
        user.logData[0].data[0].datum = [0.0, 0.0]
        
        
        date = date.addingTimeInterval(86400)
        user.logData[0].data.append(UserInformation.LogData.Data())
        user.logData[0].data[1].date = date
        user.logData[0].data[1].datum = [1.0, 2.0]
        
        date = date.addingTimeInterval(86400)
        user.logData[0].data.append(UserInformation.LogData.Data())
        user.logData[0].data[2].date = date
        user.logData[0].data[2].datum = [2.0, 5.0]
        
        date = date.addingTimeInterval(86400)
        user.logData[0].data.append(UserInformation.LogData.Data())
        user.logData[0].data[3].date = date
        user.logData[0].data[3].datum = [3.0, -2.0]
        
        date = date.addingTimeInterval(86400)
        user.logData[0].data.append(UserInformation.LogData.Data())
        user.logData[0].data[4].date = date
        user.logData[0].data[4].datum = [4.0, 1.0]
        
        return DetailView(user: user, dataNumber: 0)
    }
}
