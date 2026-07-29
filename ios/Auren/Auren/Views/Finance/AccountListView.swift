//
//  AccountListView.swift
//  Auren
//
//  Created by Mattis Lefranc Adam on 29.07.2026.
//

import SwiftUI

struct AccountListView: View {
    @StateObject private var viewModel = AccountListViewModel()
    @State private var navigateToCreateFinancialAccount = false

    @EnvironmentObject var session: SessionManager

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                }
                else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
                else if !viewModel.hasAccount {
                    Button("Create a financial account") {
                        navigateToCreateFinancialAccount = true
                    }
                    .buttonStyle(.borderedProminent)
                }
                else {
                    List(viewModel.accounts) { account in
                        NavigationLink(value: account.id) {
                            VStack(alignment: .leading) {
                                Text(account.name)
                                    .font(.headline)
                                Text(account.id.formatted())
                            }
                        }
                    }
                }
            }
            .navigationTitle("Accounts")
            .navigationDestination(for: Int.self) { id in
                AccountDetailView(id: id)
            }
            .navigationDestination(isPresented: $navigateToCreateFinancialAccount) {
                //CreateFinancialAccountView()
                // Create the Form
            }
            .task {
                await viewModel.loadAccounts(session: session.self)
            }
        }
    }
}
