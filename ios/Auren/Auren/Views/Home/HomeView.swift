//
//  HomeView.swift
//  Auren
//
//  Created by Mattis Lefranc Adam on 28.07.2026.
//


import SwiftUI

struct HomeView: View {
    @EnvironmentObject var session: SessionManager
    @StateObject private var viewModel = HomeViewModel()
    @State private var navigateToCreateFinancialAccount = false

    var body: some View {
        VStack(spacing: 20) {
            if viewModel.isLoading {
                ProgressView()
            } else if let user = session.currentUser {
                Text("Bonjour, \(user.username) 👋")
                    .font(.title)

                if viewModel.hasAccount {
                    Text("Vue globale du compte à venir ici")
                    // TODO: AccountOverviewView
                } else {
                    Text("Tu n'as pas encore de compte")
                    Button("Créer mon compte") {
                        navigateToCreateFinancialAccount = true
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .padding()
        .task {
            if let user = session.currentUser {
                await viewModel.checkAccount(userId: user.id)
            }
        }
        .navigationDestination(isPresented: $navigateToCreateFinancialAccount) {
            CreateFinancialAccountView()
        }
    }
}