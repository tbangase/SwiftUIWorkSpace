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
        var data = [[Double]]()
    }
    
    var name: String
    
    var level: Double
    var exp: Double
    
    var logData: [String : LogData]
    
    
    init() {
        self.name = "Example"
        self.level = 0
        self.exp = 0
        
        self.logData = [String : LogData]()
    }
}
