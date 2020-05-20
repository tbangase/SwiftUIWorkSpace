//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Toshiki Ichibangase on 2020/05/10.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?
    
    public var wrappedName: String {
        name ?? "Unkown Name"
    }

}
