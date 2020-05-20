//
//  AstronautView.swift
//  Moonshot
//
//  Created by Toshiki Ichibangase on 2020/04/30.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let asignedMissions: [Mission]
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    ForEach(self.asignedMissions,id: \.id) { mission in
                        NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                            HStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .padding(.top)
                                
                                Spacer()
                                
                                VStack(alignment: .trailing) {
                                    Text(mission.displayName)
                                        .font(.headline)
                                    
                                    HStack {
                                        ForEach(mission.crew, id: \.role) { crew in
                                            Text(self.astroFullName(name: crew.name))
                                            
                                            /*if let match = astronauts.first(where: { $0.id == crew.name }) {
                                                Text(match.name)
                                            } else {
                                                Text("No members.")
                                            }*/
                                        }
                                    }
                                }
                                
                            }
                            .padding()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        var matches = [Mission]()
        
        for mission in missions {
            for crew in mission.crew {
                if crew.name == astronaut.id {
                    matches.append(mission)
                    
                }
            }
        }
        
        
        self.asignedMissions = matches
    }
    
    func astroFullName(name: String) -> String {
        if let match = astronauts.first(where: { $0.id == name } ) {
            return match.name
        } else {
            fatalError("Missing \(name)")
        }
    }
    
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions)
    }
}
