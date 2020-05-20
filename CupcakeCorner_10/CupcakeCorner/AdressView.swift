//
//  AdressView.swift
//  CupcakeCorner
//
//  Created by Toshiki Ichibangase on 2020/05/05.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct AdressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.data.name)
                TextField("Street Adress", text: $order.data.streetAdress)
                TextField("City", text: $order.data.city)
                TextField("Zip", text: $order.data.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
            }
            .disabled(order.data.hasValidAdress == false)
        }
    }
}

struct AdressView_Previews: PreviewProvider {
    static var previews: some View {
        AdressView(order: Order())
    }
}
