import SwiftUI

// RootView.swift
struct RootView: View {
    @EnvironmentObject private var session: SessionManager

    var body: some View {
        if session.isAuthenticated {
            TabView {
                NavigationStack {
                    HomeView()
                }
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

                NavigationStack {
                    AccountListView()
                }
                .tabItem {
                    Label("Accounts", systemImage: "building.columns.fill")
                }
            }
        } else {
            NavigationStack {
                LoginView()
            }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(SessionManager())
}
