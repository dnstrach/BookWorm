//
//  BookDetailView.swift
//  Bookworm
//
//  Created by Dominique Strachan on 12/18/23.
//

import SwiftUI
import SwiftData

struct BookDetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    let book: Book
    
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre.uppercased())
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.70))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            
            VStack(alignment: .center) {
                Text(book.author)
                    .font(.title)
                    .foregroundStyle(.secondary)
                
                Text(book.date.formatted(date: .abbreviated, time: .omitted))
                    .fontWeight(.thin)

                Text(book.review)
                    .padding()
                    .padding([.horizontal], 30)

                RatingView(rating: .constant(book.rating))
                    .font(.largeTitle)
            }
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete Book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button("Delete this book", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
    }
    
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let book = Book(title: "Grit", author: "FirstName LastName", genre: "Fantasy", review: "Loved it!", rating: 5, date: Date.now)
        
        return BookDetailView(book: book)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
