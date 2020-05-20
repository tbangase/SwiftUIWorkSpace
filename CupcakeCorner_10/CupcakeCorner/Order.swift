//
//  Order.swift
//  CupcakeCorner
//
//  Created by Toshiki Ichibangase on 2020/05/05.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import Foundation

class Order: ObservableObject, Codable {
    
    @Published var data: OrderData
    
    required init(from decoder: Decoder) throws {
        data = OrderData()
        let container = try decoder.container(keyedBy: OrderData.CodingKeys.self)
           
        data.type = try container.decode(Int.self, forKey: .type)
        data.quantity = try container.decode(Int.self, forKey: .quantity)
           
        data.extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        data.addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
           
        data.name = try container.decode(String.self, forKey: .name)
        data.streetAdress = try container.decode(String.self, forKey: .streetAdress)
        data.city = try container.decode(String.self, forKey: .city)
        data.zip = try container.decode(String.self, forKey: .zip)
    }
    
    init() {
        data = OrderData()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: OrderData.CodingKeys.self)
        
        try container.encode(data.type, forKey: .type)
        try container.encode(data.quantity, forKey: .quantity)
        
        try container.encode(data.extraFrosting, forKey: .extraFrosting)
        try container.encode(data.addSprinkles, forKey: .addSprinkles)
        
        try container.encode(data.name, forKey: .name)
        try container.encode(data.streetAdress, forKey: .streetAdress)
        try container.encode(data.city, forKey: .city)
        try container.encode(data.zip, forKey: .zip)
    }
}


struct  OrderData: Codable {
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAdress, city, zip
    }
    static let types = ["Vanilla","Strawberry","Chocolate","Rainbow"]
    
    var type = 0
    var quantity = 3
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    var name = ""
    var streetAdress = ""
    var city = ""
    var zip = ""
    
    var hasValidAdress: Bool {
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        let trimmedAdress = streetAdress.trimmingCharacters(in: .whitespaces)
        let trimmedCity = city.trimmingCharacters(in: .whitespaces)
        let trimmedZip = zip.trimmingCharacters(in: .whitespaces)
        
        if trimmedName.isEmpty || trimmedAdress.isEmpty || trimmedCity.isEmpty || trimmedZip.isEmpty {
            return false
        }
        return true
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        cost += Double(type) / 2
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}
