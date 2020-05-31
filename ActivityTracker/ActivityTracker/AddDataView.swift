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
                    Text("How much \(self.user.info.logData[self.dataNumber].dataName)?")
                        .font(.title)
                        .frame(width: geo.size.width - 20, alignment: .leading)
                    
                    TextField("Example: 23.34", text: self.$data)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 5)
                        .padding(.bottom, 50)
                }
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Add")
                        .font(.title)
                        .padding()
                        .frame(width: geo.size.width - 20)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                Spacer()
            }
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
        
        return AddDataView(user: user, dataNumber: 0)
    }
}
