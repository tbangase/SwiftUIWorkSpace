//
//  ContentView.swift
//  BucketList
//
//  Created by Toshiki Ichibangase on 2020/05/16.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import LocalAuthentication
import SwiftUI

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
    
}

enum LoadingState {
    case loading, success, failed
}

struct ContentView: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
        User(firstName: "Toshiki", lastName: "Ichibangase"),
        User(firstName: "Kimiya", lastName: "Ichibangase"),
    ].sorted()
    
    @State private var loadingState = LoadingState.loading
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                MapView()
                    .edgesIgnoringSafeArea(.all)
            } else {
                Text("Locked.")
            }
            
            /*
            List(users) { user in
                Text(user.firstName + " " + user.lastName)
            }
            
            Group {
                if loadingState == .loading {
                    LoadingView()
                } else if loadingState == .success {
                    SuccessView()
                } else if loadingState == .failed {
                    FailedView()
                }
            }
            
            HStack {
                Button("Loading") {
                    self.loadingState = LoadingState.loading
                }
                
                Button("Success") {
                    self.loadingState = LoadingState.success
                }
                
                Button("Fail") {
                    self.loadingState = LoadingState.failed
                }
            }*/
        }.onAppear(perform: authenticate)
        
        
    }
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        //there was a problem
                    }
                }
                
            }
        } else {
            //no biometrics
        }
    }
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
