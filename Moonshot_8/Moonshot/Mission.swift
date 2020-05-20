//
//  Mission.swift
//  Moonshot
//
//  Created by Toshiki Ichibangase on 2020/04/30.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Appllo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.dateFormat = "yyyy年MM月dd日"
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
}
