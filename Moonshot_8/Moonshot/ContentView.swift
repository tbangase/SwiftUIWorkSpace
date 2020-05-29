//
//  ContentView.swift
//  Moonshot
//
//  Created by Toshiki Ichibangase on 2020/04/29.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showMember = false
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if self.showMember {
                            HStack {
                                ForEach(mission.crew,id: \.role) { crew in
                                    Text(self.astroFullName(name: crew.name))
                                }
                            }
                        } else {
                            Text("Launch Date: " + mission.formattedLaunchDate)
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button("Date/Member") {
                self.showMember.toggle()
            })
        }
    }
    func astroFullName(name: String) -> String {
        if let match = astronauts.first(where: { $0.id == name } ) {
            return match.name
        } else {
            fatalError("Missing \(name)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
