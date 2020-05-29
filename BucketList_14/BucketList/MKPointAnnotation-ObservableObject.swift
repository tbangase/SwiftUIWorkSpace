//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Toshiki Ichibangase on 2020/05/23.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? "Unknown Title"
        }
        
        set {
            title = newValue
        }
    }
    
    public var wrappedSubTitle: String {
        get {
            self.subtitle ?? "Unknown Subtitle"
        }
        
        set {
            subtitle = newValue
        }
    }
}
