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
            ZStack {
                Color.aurenBackground.ignoresSafeArea()
                Group {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                    }
                    else if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                    }
                    else if !viewModel.hasAccount {
                        AUButton(title: "Create a financial account", style: .ghost, width: 250, fontSize: 20) {
                            navigateToCreateFinancialAccount = true
                        }.buttonStyle(.bordered)
                    }
                    else {
                        List {
                            ForEach(viewModel.accounts) { account in
                                NavigationLink(value: account.id) {
                                    VStack(alignment: .leading) {
                                        Text(account.name)
                                            .font(.headline)
                                        Text(account.amount.formatted(.number.precision(.fractionLength(2))))
                                    }
                                }
                            }
                            .onDelete { indexSet in
                                Task {
                                    await viewModel.deleteAccount(at: indexSet, session: session)
                                }
                            }

                            AUButton(title: "Create a financial account", style: .ghost, width: 200) {
                                navigateToCreateFinancialAccount = true
                            }.buttonStyle(.bordered)
                        }
                    }
                }
            }
            .navigationTitle("Accounts")
            .navigationDestination(for: Int.self) { id in
                AccountDetailView(id: id)
            }
            .navigationDestination(isPresented: $navigateToCreateFinancialAccount) {
                CreateFinancialAccountView()
            }
            .task {
                await viewModel.loadAccounts(session: session.self)
            }
        }
    }
}
