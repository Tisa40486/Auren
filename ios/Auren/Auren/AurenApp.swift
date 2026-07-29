//
//  AurenApp.swift
//  Auren
//
//  Created by Mattis Lefranc Adam on 28.07.2026.
//

import SwiftUI

@main
struct AurenApp: App {
    @StateObject private var session = SessionManager()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
            }
            .environmentObject(session)
        }
    }
}


