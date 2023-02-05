//
//  DetailView.swift
//  FriendFace
//
//  Created by Toshiki Ichibangase on 2020/06/15.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @FetchRequest(entity: UserInfo.entity(), sortDescriptors: []) var users: FetchedResults<UserInfo>
    //var users: User
    @State var index: Int
    
    var body: some View {
        let user = users[index]
        return GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    
                    Text("\(user.wrappedName)")
                        .font(.largeTitle)
                        .padding()
                    
                    Text("\(user.wrappedEmail)")
                        .font(.headline)
                        .padding()
                        .padding(.bottom)
                    
                    
                    VStack(alignment: .leading) {
                        Text("Age: \(user.age)")
                        Text("Company: \(user.wrappedCompany)")
                        Text("Adress: \(user.adress ?? "Unknown Adress")")
                        Text(user.about ?? "")
                            .padding(.vertical)
                        
                        Text("Friends")
                            .font(.title)
                            .padding(3)
                        
                        ForEach(user.friendsArray, id: \.self) { friend in
                            VStack(alignment: .leading) {
                                Button(action: {
                                    withAnimation {
                                        self.findFriendIndex(id: friend.id ?? "unknown id")
                                    }
                                }) {
                                    Text("\(friend.wrappedName)")
                                        .font(.headline)
                                        .padding(3)
                                }.buttonStyle(PlainButtonStyle())
                                
                                Divider()
                            }
                        }
                    }
                    .padding(.horizontal)
                    .frame(width: geo.size.width)
                }
            }
        }
    }
    
    func findFriendIndex(id: String) {
        index = users.firstIndex(where: { $0.wrappedId == id }) ?? 0
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(index: 0)
    }
}
