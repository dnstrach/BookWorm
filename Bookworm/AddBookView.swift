//
//  AddBookView.swift
//  Bookworm
//
//  Created by Dominique Strachan on 12/18/23.
//

import SwiftData
import SwiftUI

struct AddBookView: View {
    @Environment (\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""

    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller", "Unknown"]
    
    var hasValidBook: Bool {
        if title.isReallyEmpty || author.isReallyEmpty || review.isReallyEmpty {
            return false
        }
        
        return true
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Book Title", text: $title)
                    TextField("Author's Name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a Review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                    
//                    Picker("Rating", selection: $rating) {
//                        ForEach(0..<6) {
//                            Text("\($0)")
//                        }
//                    }
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, date: Date.now)
                        modelContext.insert(newBook)
                        
                        dismiss()
                    }
                }
                .disabled(hasValidBook == false)
            }
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}
