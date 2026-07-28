//
//  RootView.swift
//  Auren
//
//  Created by Mattis Lefranc Adam on 28.07.2026.
//


import SwiftUI

struct RootView: View {
    @EnvironmentObject var session: SessionManager

    var body: some View {
        Group {
            if session.isAuthenticated {
                HomeView()
            } else {
                LoginView()
            }
        }
    }
}
