//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Toshiki Ichibangase on 2020/04/29.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        print(data)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
}
