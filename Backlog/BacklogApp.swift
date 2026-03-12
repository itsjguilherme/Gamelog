//
//  BacklogApp.swift
//  Backlog
//
//  Created by User on 25/02/26.
//

import SwiftUI
import SwiftData

@main
struct BacklogApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Game.self])
    }
}
