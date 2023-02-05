//
//  User.swift
//  FriendFace
//
//  Created by Toshiki Ichibangase on 2020/06/14.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import Foundation

class User: ObservableObject, Codable {
    
    var userData: [UserData]
    
    init() {
        userData = [UserData]()
        /*let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Read data from url error.")
                return
            }
            
            if let decoded = try? JSONDecoder().decode([UserData].self, from: data) {
                self.userData = decoded
            } else {
                print("\(data)")
                print("Decode from data error.")
            }
        }.resume()*/
    }
}

struct UserData: Codable, Hashable, Identifiable {
    static func == (lhs: UserData, rhs: UserData) -> Bool {
        lhs.id == rhs.id
    }
    
    struct Friend: Codable, Hashable, Identifiable {
        public var id: String
        var name: String
    }
    
    enum CodingKeys: CodingKey {
        case id, isActive, name, age, company, email, adress,
         about, registered, tags, friends
    }

    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var adress: String?
    var about: String
    var registered: String
    var tags: [String]
    var friends: [Friend]
}


