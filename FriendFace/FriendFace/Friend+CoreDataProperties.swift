//
//  Friend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Toshiki Ichibangase on 2020/06/21.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var user: UserInfo?
    
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
}
