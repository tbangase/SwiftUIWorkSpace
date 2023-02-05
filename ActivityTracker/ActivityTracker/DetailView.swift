//
//  DetailView.swift
//  ActivityTracker
//
//  Created by Toshiki Ichibangase on 2020/05/29.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var mode
    @ObservedObject var user: UserInformation
    
    @State private var showingAddData = false
    
    @GestureState private var dragOffset = CGSize.zero
    
    let dataNumber: Int
    @Binding var needReflesh: Bool
    @State var hiddenTrigger = false
    //var dataset: [[Double]]
    
    var body: some View {
        let logdata = user.info.logData[dataNumber]
        
        return ZStack {
            ScrollView(.vertical) {
                LineChartView(dataSet: dataSet())
                    .frame(width: 300, height: 200)
                
                VStack(alignment: .leading){
                    HStack {
                        Text("Max \(logdata.dataName) ")
                        
                        Spacer()
                        
                        if logdata.maxData == 0 {
                            Text("No Data")
                                .foregroundColor(.red)
                                .font(.body)
                                .padding(.trailing, 30)
                        } else {
                            Text("\(logdata.maxData, specifier: "%.2f")")
                                .foregroundColor(.white)
                                .padding(.trailing, 30)
                        }
                        
                    }
                    .padding()
                    
                    HStack {
                        Text("Min \(logdata.dataName) ")
                        
                        Spacer()
                        
                        if logdata.minData == 0 {
                            Text("No Data")
                                .foregroundColor(.red)
                                .font(.body)
                                .padding(.trailing, 30)
                        } else {
                            Text("\(logdata.minData, specifier: "%.2f")")
                                .foregroundColor(.white)
                                .padding(.trailing, 30)
                        }
                    }
                    .padding()
                    
                    HStack {
                        Text("Mean of \(logdata.dataName) ")
                        
                        Spacer()
                        
                        if logdata.meanData == 0 {
                            Text("No Data")
                                .foregroundColor(.red)
                                .font(.body)
                                .padding(.trailing, 30)
                        } else {
                            Text("\(logdata.meanData, specifier: "%.2f")")
                                .foregroundColor(.white)
                                .padding(.trailing, 30)
                        }
                    }
                    .padding()
                    
                    
                }.font(.title)
                .background(Color.green)
                .foregroundColor(.white)
                .clipShape(Rectangle())
                    .shadow(radius: 10, x: 5,y: 5)
                .padding(8)
                
                
                ForEach(0..<logdata.data.count, id: \.self) { num in
                    VStack {
                        Divider()
                        
                        Text(self.displayShortDate(date: logdata.data[logdata.data.count - 1 - num].date))
                        + Text("   ")
                        + Text("\(logdata.dataName): ")
                        + Text("\(logdata.data[logdata.data.count - 1 - num].datum[1], specifier: "%.2f")")
                            .font(.headline)
                    }
                }
                Divider()
            }
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.showingAddData = true
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 30, height: 30)
                        
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Rectangle())
                    .buttonStyle(PlainButtonStyle())
                    .shadow(radius: 5, y: 5)
                    .padding()
                }
            }
        }
        .sheet(isPresented: $showingAddData) {
            AddDataView(user: self.user, dataNumber: self.dataNumber, needReflesh: self.$needReflesh)
        }
        .navigationBarTitle(user.info.logData[dataNumber].logName)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.needReflesh.toggle()
            self.hiddenTrigger.toggle()
            self.mode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrow.left")
                Text("Activity")
            }
        })
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
            if(value.startLocation.x < 20 && value.translation.width > 100) {
                self.mode.wrappedValue.dismiss()
            }
        }))
    }
    
    func dataSet() -> [[Double]] {
        var dataset = [[Double]]()
        let logData = user.info.logData[dataNumber]
        
        for data in logData.data {
            dataset.append(data.datum)
        }
        
        return dataset
        //return [[0.0,0.0], [1.0, 2.0]]
    }
    
    func displayShortDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
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
        user.info.logData.append(UserData.LogData())
        user.info.logData[0].logName = "Log Name"
        
        
        var date = Date()
        user.info.logData[0].data.append(UserData.LogData.Data())
        user.info.logData[0].data[0].date = date
        user.info.logData[0].data[0].datum = [0.0, 0.0]
        
        date = date.addingTimeInterval(86400)
        user.info.logData[0].data.append(UserData.LogData.Data())
        user.info.logData[0].data[1].date = date
        user.info.logData[0].data[1].datum = [1.0, 2.0]
        
        date = date.addingTimeInterval(86400)
        user.info.logData[0].data.append(UserData.LogData.Data())
        user.info.logData[0].data[2].date = date
        user.info.logData[0].data[2].datum = [2.0, 5.0]
        
        date = date.addingTimeInterval(86400)
        user.info.logData[0].data.append(UserData.LogData.Data())
        user.info.logData[0].data[3].date = date
        user.info.logData[0].data[3].datum = [3.0, -2.0]
        
        date = date.addingTimeInterval(86400)
        user.info.logData[0].data.append(UserData.LogData.Data())
        user.info.logData[0].data[4].date = date
        user.info.logData[0].data[4].datum = [4.0, 1.0]
        
        user.info.logData[0].maxData = 12
        
        return DetailView(user: user, dataNumber: 0, needReflesh: .constant(false))
    }
}
