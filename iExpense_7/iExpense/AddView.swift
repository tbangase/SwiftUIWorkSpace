//
//  AddView.swift
//  iExpense
//
//  Created by Toshiki Ichibangase on 2020/04/28.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isShowAlert = false
    
    static let types = ["Buisiness", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type",selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Double(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.saveToUserdefaults(items: self.expenses.items)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.alertTitle = "Error"
                    self.alertMessage = "Please Enter Number in Amount."
                    self.isShowAlert = true
                    self.amount = ""
                    return
                }
            })
            .alert(isPresented: $isShowAlert) {
                Alert(title: Text(self.alertTitle), message: Text(self.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func saveToUserdefaults(items: [ExpenseItem]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            UserDefaults.standard.set(encoded, forKey: "Items")
        }
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
