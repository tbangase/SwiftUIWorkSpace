//
//  MissionView.swift
//  Moonshot
//
//  Created by Toshiki Ichibangase on 2020/04/30.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronouts: [CrewMember]
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame( maxWidth: geo.size.width * 0.7 )
                        .padding(.top)
                    GeometryReader { geo in
                        ZStack {
                            Text("Launch : " + self.mission.formattedLaunchDate)
                                .font(.title)
                        
                            RoundedRectangle(cornerRadius: 10)
                                .opacity(0.2)
                                .frame(width: geo.size.width-20, height: 70)
                                .position(x: geo.size.width/2, y: geo.size.height/2)
                            
                        }
                    }
                    .frame(height: 70, alignment: .center)
                    
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronouts,id: \.role) { crewMember in
                        NavigationLink(destination:
                        AstronautView(astronaut: crewMember.astronaut, missions: self.missions)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.primary, lineWidth: 3))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name } ) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        self.astronouts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        MissionView(mission: missions[1],astronauts: astronauts)
    }
}
