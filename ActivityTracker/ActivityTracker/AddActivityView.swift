//
//  AddActivityView.swift
//  ActivityTracker
//
//  Created by Toshiki Ichibangase on 2020/05/29.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var user: UserInformation
    
    @State private var activityName = ""
    @State private var category = 0
    @State private var dataName = ""
    @State private var showingPicker = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
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
                        
                        Text("New Activity")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(width: geo.size.width - 20, alignment: .leading)
                            .padding(.top, 30)
                    }
                    
                    Divider().padding(.bottom, 20)
                    
                    Group {
                        Text("Activity Name")
                            .font(.title)
                            .frame(width: geo.size.width - 20, alignment: .leading)
                        
                        TextField("Example: Training", text: self.$activityName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, 5)
                            .padding(.bottom, 50)
                    }
                    
                    Group {
                        ZStack {
                            HStack {
                                Spacer()
                                
                                Button(action:{
                                    
                                }) {
                                    Image(systemName: "plus")
                                        .padding(8)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .clipShape(Capsule())
                                        .padding(.horizontal, 10)
                                        
                                    
                                }.buttonStyle(PlainButtonStyle())
                            }
                            
                            Text("Category")
                                .font(.title)
                                .frame(width: geo.size.width - 20, alignment: .leading)
                        }
                        
                        Divider()
                        
                        Button(action: {
                            withAnimation {
                                self.showingPicker.toggle()
                            }
                        }) {
                            HStack {
                                Spacer()
                                Text(self.user.info.categories[self.category])
                                    .font(.headline)
                                    .padding(.horizontal, 10)
                                
                                Spacer()
                                
                                if self.showingPicker {
                                    Image(systemName: "chevron.up")
                                        .padding(.horizontal, 10)
                                } else {
                                    Image(systemName: "chevron.down")
                                        .padding(.horizontal, 10)
                                }
                                
                            }
                        }
                        Divider()
                    
                        if self.showingPicker {
                            Picker(selection: self.$category, label: Text("Pickup categories")) {
                                ForEach(0..<self.user.info.categories.count) { item in
                                    Text("\(self.user.info.categories[item])")
                                }
                            }.labelsHidden()
                        }
                        
                        
                    }
                    
                    Text("Choose one data to save log.")
                        .frame(width: geo.size.width - 20, alignment: .leading)
                        .font(.headline)
                        .padding(.top, 50)
                    
                    Text("If you really want to track your activity, the best way is just tracking one data. So, please choose JUST ONE of the data you want tracking.")
                        .frame(width: geo.size.width - 20, alignment: .leading)
                        .padding(.vertical, 20)
                    
                    
                    Group {
                        Text("Data Name")
                            .font(.title)
                            .frame(width: geo.size.width - 20, alignment: .leading)
                            .padding(.top)
                        
                        TextField("Example: Trained time (Minute)", text: self.$dataName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, 5)
                            .padding(.bottom, 30)
                    }
                    
                    Button(action: {
                        self.createActivity()
                        self.saveToUserdefaults(items: self.user.info)
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                            .font(.title)
                            .padding()
                            .frame(width: geo.size.width - 20)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Rectangle())
                    }
                    Spacer()
                }
            }
        }
        .navigationBarItems(trailing:
            Button("Cancel") {
                self.presentationMode.wrappedValue.dismiss()
            }
        )
    }
    
    func createActivity() {
        let appendData = UserData.LogData()
        appendData.logName = activityName
        appendData.category = user.info.categories[category]
        appendData.dataName = dataName
        
        user.info.logData.append(appendData)
        
        user.objectWillChange.send()
    }
    
    func saveToUserdefaults(items: UserData) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            UserDefaults.standard.set(encoded, forKey: "User")
            print(encoded)
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        let user = UserInformation()
        
        return AddActivityView(user: user)
    }
}
