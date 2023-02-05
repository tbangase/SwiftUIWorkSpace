//
//  ContentView.swift
//  FriendFace
//
//  Created by Toshiki Ichibangase on 2020/06/14.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: UserInfo.entity(), sortDescriptors: []) var users: FetchedResults<UserInfo>
    
    //var users = User()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                if users.count == 0  {
                    Text("No Data")
                } else {
                    ForEach(0..<users.count, id: \.self) { index in
                        NavigationLink(destination:
                        DetailView(index: index)) {
                            VStack {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("\(self.users[index].wrappedName)")
                                            .font(.headline)
                                        
                                        Text("\(self.users[index].wrappedEmail)")
                                    }.padding(.horizontal)
                                    
                                    Spacer()
                                    
                                }
                                Divider()
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .navigationBarTitle("User List")
        }
        .onAppear(perform: {
            var userData = [UserData]()
            if self.users.count == 0 {
                let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                
                URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data else {
                        print("Read data from url error.")
                        return
                    }
                    
                    if let decoded = try? JSONDecoder().decode([UserData].self, from: data) {
                        userData = decoded
                        self.saveData(userData: userData)
                    } else {
                        print("\(data)")
                        print("Decode from data error.")
                    }
                }.resume()
            }
        })
    }
    
    func saveData(userData: [UserData]) {
        
        for user in userData {
            let data = UserInfo(context: self.moc)
            data.about = user.about
            data.adress = user.adress
            data.age = Int16(user.age)
            data.company = user.company
            data.email = user.email
            data.id = user.id
            data.isActive = user.isActive
            data.name = user.name
            data.registered = user.registered
            data.tags = user.tags
            
            let friends = user.friends
            let friendsData = Friend(context: self.moc)
            for friend in friends {
                friendsData.id = friend.id
                friendsData.name = friend.name
                friendsData.user = data
            }
            try? self.moc.save()
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
