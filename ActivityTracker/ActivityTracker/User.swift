//
//  User.swift
//  Tabbed_app_test
//
//  Created by Toshiki Ichibangase on 2020/05/23.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import Foundation

class UserInformation: ObservableObject {
    @Published var info: UserData {
        didSet {
            /*let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(info) {
                UserDefaults.standard.set(encoded, forKey: "User")
                print(encoded)
            }*/
        }
    }
    
    init() {
       /* if let info = UserDefaults.standard.data(forKey: "User") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(UserData.self, from: info) {
                self.info = decoded
                return
            }
        }*/
        
        self.info = UserData()
    }
}

class UserData: Codable {
    class LogData: Codable {
        class Data: Codable {
            
            var datum: [Double]
            var date: Date
            
            init() {
                self.datum = [Double]()
                self.date = Date()
            }
        }
        var logName: String
        var category: String
        var data: [Data]
        var dataName: String
        
        var maxData:  Double = 0
        var minData:  Double = 0
        var meanData: Double = 0
        
        init() {
            self.logName = "Annonymous"
            self.category = "Health"
            self.data = [Data]()
            self.dataName = "Data"
        }
    }
    var name: String
    var logData: [LogData]
    var categories: [String]
    
    
    init() {
        self.name = "Guest"
        self.logData = [LogData]()
        self.categories = ["Health", "Ambition", "Relation", "Money", "Others"]
        //self.level = 0
        //self.exp = 0
    }
}
