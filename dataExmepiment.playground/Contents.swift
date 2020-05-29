import UIKit

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
        var data: [Data]
        
        init() {
            self.logName = ""
            self.data = [Data]()
        }
    }
    var name: String
    
    //var level: Double
    //var exp: Double
    
    var logData: [LogData]
    
    
    init() {
        self.name = "Example"
        //self.level = 0
        //self.exp = 0
        
        self.logData = [LogData]()
    }
}

var user = UserInformation()

user.logData.append(UserInformation.LogData())
user.logData[0].logName
user.logData[0].data.append(UserInformation.LogData.Data())
user.logData[0].data[0].datum = [1.0, 2.0]
user.logData[0].data[0].datum
user.logData[0].data.append(UserInformation.LogData.Data())
user.logData[0].data[1].datum = [2.0, 5.0]
user.logData[0].data[1].datum
user.logData[0].data.append(UserInformation.LogData.Data())
user.logData[0].data[2].datum

var date = Date()

date = date.addingTimeInterval(86400)

date
