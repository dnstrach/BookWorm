//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Dominique Strachan on 12/15/23.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
