//
//  ContentView.swift
//  UnitConversion
//
//  Created by Toshiki Ichibangase on 2020/04/21.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let units = ["meters","kilometers","feet","yard","miles"]
    @State var selectedOriginUnit: Int = 0
    @State var selectedTargetUnit: Int = 0
    @State var amount: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input information")) {
                    TextField("Number before conversion", text: $amount)
                        .keyboardType(.decimalPad)
                    Picker("Select ORIGIN unit", selection: $selectedOriginUnit) {
                        ForEach(0..<units.count) {
                            Text(self.units[$0])
                        }
                    }
                }
                
                Section(header: Text("Conversion setting")) {
                    Picker("Select TARGET unit", selection: $selectedTargetUnit) {
                        ForEach(0..<units.count) {
                            Text(self.units[$0])
                        }
                    }
                }
                
                Section(header: Text("Result")) {
                    Text("\(calcUnit(),specifier: "%.6f")")
                }
            }
            .navigationBarTitle("Unit conversion")
        }
    }
    
    func calcUnit() -> Double {
        let number = Double(amount) ?? 0.0
        return targetNumber(mediumNumber(number))
    }
    
    func mediumNumber(_ number: Double) -> Double {
        switch selectedOriginUnit {
        case 0: //meter to meter
            return number
        case 1: //kilometer to meter
            return number * 1000
        case 2: //feet to meter
            return number / 3.2808
        case 3: //yard to meter
            return number / 1.0936
        case 4: //miles to meter
            return number / 0.00062137
        default:
            return 0
        }
    }
    
    func targetNumber(_ number: Double) -> Double {
        switch selectedTargetUnit {
        case 0:
            return number
        case 1: //meter to kilometer
            return number / 1000
        case 2: //meter to feet
            return number * 3.2808
        case 3: // meter to yard
            return number * 1.0936
        case 4: // meter to miles
            return number * 0.00062137
        default:
            return 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
