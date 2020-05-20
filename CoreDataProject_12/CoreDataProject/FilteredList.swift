//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Toshiki Ichibangase on 2020/05/10.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }
    
    let content: (T) -> Content
    
    enum predicates: String {
        case beginsWith = "BEGINSWITH"
    }
    
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }
    
    init(filterKey: String, filter: String, @ViewBuilder content: @escaping (T) -> Content) {
        
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [
            NSSortDescriptor(key: filterKey, ascending: true)
        ], predicate: NSPredicate(format: "%K \(predicates.beginsWith) %@", filterKey, filter))
        self.content = content
    }
}
