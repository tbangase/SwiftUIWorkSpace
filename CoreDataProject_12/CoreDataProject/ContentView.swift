//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Toshiki Ichibangase on 2020/05/09.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "universe == %@", "Star Wars")) var ships: FetchedResults<Ship>
    @FetchRequest(entity: Singer.entity(), sortDescriptors: []) var singers: FetchedResults<Singer>
    @FetchRequest(entity: Country.entity(), sortDescriptors: []) var countries: FetchedResults<Country>
    
    @State private var lastNameFilter = "A"
    
    var body: some View {
        VStack {
            List {
                ForEach(countries, id: \.self) { country in
                    Section(header: Text(country.wrappedFullName)) {
                        ForEach(country.candyArray, id:\.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            
            Button("Add") {
                let candy1 = Candy(context: self.moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: self.moc)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"
                
                let candy2 = Candy(context: self.moc)
                candy2.name = "KitKat"
                candy2.origin = Country(context: self.moc)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"
                
                let candy3 = Candy(context: self.moc)
                candy3.name = "Twix"
                candy3.origin = Country(context: self.moc)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"
                
                let candy4 = Candy(context: self.moc)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: self.moc)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"
                
                try? self.moc.save()
            }
            
            Group {
                FilteredList(filterKey: "lastName", filter: lastNameFilter) { (singer: Singer) in
                    Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
                }
                
                Button("Add Examples") {
                    let taylor = Singer(context: self.moc)
                    taylor.firstName = "Taylor"
                    taylor.lastName = "Swift"
                    
                    let sota = Singer(context: self.moc)
                    sota.firstName = "Sota"
                    sota.lastName = "Sato"
                    
                    let secret = Singer(context: self.moc)
                    secret.firstName = "Himitu"
                    secret.lastName = "Secret"
                    
                    let ed = Singer(context: self.moc)
                    ed.firstName = "Ed"
                    ed.lastName = "Sheeran"
                    
                    let adele = Singer(context: self.moc)
                    adele.firstName = "Adele"
                    adele.lastName = "Adkins"
                    
                    try? self.moc.save()
                }
                
                HStack {
                    Button("Show A") {
                        self.lastNameFilter = "A"
                    }
                    
                    Button("Show S") {
                        self.lastNameFilter = "S"
                    }
                }
                
                Button("Delete") {
                    self.deleteAllSinger()
                }
                .foregroundColor(.red)
            }
            
            /*
            List(ships, id:\.self) { ship in
                Text(ship.name ?? "Unknown Name")
            }
            
            Button("Add Examples") {
                let ship1 = Ship(context: self.moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"
                
                let ship2 = Ship(context: self.moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"
                
                let ship3 = Ship(context: self.moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"
                
                let ship4 = Ship(context: self.moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"
                
                try? self.moc.save()
            }
            
            Button("Delete") {
                self.deleteAllShip()
            }
            .foregroundColor(Color.red)
            
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown Name")
            }
            
            HStack {
                Button("Add") {
                    let wizard = Wizard(context: self.moc)
                    wizard.name = "Harry potter"
                }
                
                Button("Save") {
                    do {
                        try self.moc.save()
                    } catch {
                        print("Error")
                        print(error.localizedDescription)
                    }
                }
            }*/
            
            Spacer(minLength: 5)
        }
    }
    
    func deleteAllShip() {
        for ship in ships {
            moc.delete(ship)
        }
        try? moc.save()
    }
    func deleteAllSinger() {
        for singer in singers {
            moc.delete(singer)
        }
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        return ContentView().environment(\.managedObjectContext, context)
    }
}
