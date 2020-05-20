//
//  DetailView.swift
//  Bookworm
//
//  Created by Toshiki Ichibangase on 2020/05/09.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import CoreData
import SwiftUI

struct DetailView: View {
    let book: Book
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre ?? "Default")
                        .frame(maxWidth: geometry.size.width)
                    
                    Text(self.book.genre?.uppercased() ?? "DEFAULT")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                
                Text(self.book.title ?? "Unknown Book")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                RatingView(rating: .constant(Int(self.book.rating)))
                
                Text(self.book.review ?? "No review yet.")
                    .padding()
                
                Spacer(minLength: 25)
                
                Text("Write at: "+self.dateString(date: self.book.date ?? Date()))
                    .frame(maxWidth: .infinity,  alignment: .trailing)
                    .padding()
            }
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        }) {
            Image(systemName: "trash")
        })
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete Book"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                self.deleteBook()
                }, secondaryButton: .cancel()
            )
        }
    }
    
    func deleteBook() {
        moc.delete(book)
        presentationMode.wrappedValue.dismiss()
    }
    
    func dateString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .long
        
        return formatter.string(from: date)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Default"
        book.rating = 3
        book.review = "I had fun from this book. It's nice book :-)"
        return DetailView(book: book)
    }
}
