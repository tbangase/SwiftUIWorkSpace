//
//  AddDataView.swift
//  ActivityTracker
//
//  Created by Toshiki Ichibangase on 2020/05/29.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

struct AddDataView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geo in
            VStack{
                Text("Add Data")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(width: geo.size.width - 20, alignment: .leading)
                    .padding(.vertical, 30)
                
                Spacer()
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Dismiss")
                        .padding()
                        .frame(width: geo.size.width - 20)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                Spacer()
            }
        }
    }
}

struct AddDataView_Previews: PreviewProvider {
    static var previews: some View {
        AddDataView()
    }
}
