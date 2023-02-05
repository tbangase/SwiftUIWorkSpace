//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Toshiki Ichibangase on 2020/05/03.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $order.data.type, label: Text("Select your cake type")) {
                        ForEach(0..<OrderData.types.count) {
                            Text(OrderData.types[$0])
                        }
                    }
                    
                    Stepper(value: $order.data.quantity, in: 1...20) {
                        Text("Number of cakes: \(order.data.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.data.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if order.data.specialRequestEnabled {
                        Toggle(isOn: $order.data.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        Toggle(isOn: $order.data.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AdressView(order: order)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
