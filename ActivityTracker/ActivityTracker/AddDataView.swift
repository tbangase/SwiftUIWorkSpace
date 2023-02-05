//
//  AddDataView.swift
//  ActivityTracker
//
//  Created by Toshiki Ichibangase on 2020/05/29.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct AddDataView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var user: UserInformation
    
    @State private var data = ""
    @State private var subscribeDate = Date()
    
    let dataNumber: Int
    @Binding var needReflesh: Bool
    
    var buttonDisabled: Bool {
        Double(data) == nil
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack{
                ZStack {
                    HStack {
                        Spacer()
                        
                        Button("Cancel") {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        .padding()
                        .foregroundColor(.red)
                        .offset(x: 0, y: 20)
                    }
                    
                    Text("Add Data")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(width: geo.size.width - 20, alignment: .leading)
                        .padding(.top, 30)
                }
                
                Divider()
                
                Spacer()
                
                Group {
                    Text("When did you do?")
                        .font(.title)
                        .frame(width: geo.size.width - 20, alignment: .leading)
                    
                    DatePicker("", selection: self.$subscribeDate)
                        .labelsHidden()
                }
                
                Group {
                    HStack {
                        Text("How much \(self.user.info.logData[self.dataNumber].dataName)?")
                            .font(.title)
                            .frame(alignment: .leading)
                            .padding(.leading, 10)
                        
                        Spacer()
                        
                        if self.buttonDisabled {
                            Text("Please enter Number.")
                                .foregroundColor(Color.red)
                                .padding(.trailing, 10)
                                .offset(y: 5)
                        }
                    }
                    
                    TextField("Example: 23.34", text: self.$data)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 5)
                        .padding(.bottom, 50)
                }
                
                Section {
                    Button(action: {
                        self.addData()
                        self.saveToUserdefaults(items: self.user.info)
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Add")
                            .font(.title)
                            .padding()
                            .frame(width: geo.size.width - 20)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Rectangle())
                    }
                }.disabled(self.buttonDisabled)
                
                Spacer()
            }
        }
    }
    
    func addData() {
        let newData = UserData.LogData.Data()
        //let numOfData = Double(user.info.logData[dataNumber].data.count)
        let logdata = user.info.logData[dataNumber]
        
        var interval = TimeInterval()
        
        if logdata.data.count == 0 {
            interval = 0.0
        } else {
            interval = subscribeDate.timeIntervalSince(logdata.data[0].date)
        }
        let xval = Double(interval) / 86400
        
        newData.date = subscribeDate
        newData.datum = [xval, Double(data) ?? 0.0]
        
        logdata.data.append(newData)
        
        //calculate statistic values
        var max = 0.0
        for i in 0..<logdata.data.count {
            if max < logdata.data[i].datum[1] {
                max = logdata.data[i].datum[1]
            }
        }
        logdata.maxData = max
        
        var min = max
        for i in 0..<logdata.data.count {
            if min > logdata.data[i].datum[1] {
                min = logdata.data[i].datum[1]
            }
        }
        logdata.minData = min
        
        var sum = 0.0
        for i in 0..<logdata.data.count {
            sum += logdata.data[i].datum[1]
        }
        logdata.meanData = sum/Double(logdata.data.count)
        
        logdata.data.sort()
        
        needReflesh.toggle()
    }
    
    func saveToUserdefaults(items: UserData) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            UserDefaults.standard.set(encoded, forKey: "User")
            print(encoded)
        }
    }
}

struct AddDataView_Previews: PreviewProvider {
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
        
        return AddDataView(user: user, dataNumber: 0, needReflesh: .constant(false))
    }
}
