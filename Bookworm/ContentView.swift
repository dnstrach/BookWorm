//
//  ContentView.swift
//  Bookworm
//
//  Created by Dominique Strachan on 12/15/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    // @Query var books: [Book]
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]
    
    @State private var showAddBookSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                            
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                    .foregroundStyle(book.rating < 3 ? .red : .primary)
                                
                                Text(book.author)
                                    .font(.subheadline)
                            }
                        }

                    }
                    .navigationDestination(for: Book.self) { book in
                        BookDetailView(book: book)
                    }
                    .opacity(book.rating < 3 ? 0.5 : 1)
                }
                .onDelete(perform: deleteBooks)
            }
            
            // test for @Query property
            //Text("Total Books: \(books.count)")
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showAddBookSheet.toggle()
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showAddBookSheet) {
                AddBookView()
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
