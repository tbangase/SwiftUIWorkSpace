//
//  User.swift
//  Tabbed_app_test
//
//  Created by Toshiki Ichibangase on 2020/05/23.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import Foundation

class UserInformation: ObservableObject {
    class LogData: ObservableObject {
        class Data: ObservableObject {
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
        
        init() {
            self.logName = "Annonymous"
            self.category = "Others"
            self.data = [Data]()
        }
    }
    var name: String
    var logData: [LogData]
    var categories: [String]
    
    
    init() {
        self.name = "Guest"
        self.logData = [LogData]()
        self.categories = [String]()
        //self.level = 0
        //self.exp = 0
    }
}
