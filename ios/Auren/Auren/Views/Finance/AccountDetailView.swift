//
//  AccountDetailView.swift
//  Auren
//
//  Created by Mattis Lefranc Adam on 29.07.2026.
//
import SwiftUI

struct AccountDetailView: View {
    @StateObject private var viewModel: AccountDetailViewModel
    @EnvironmentObject var session: SessionManager
    
    init(id: Int) {
        _viewModel = StateObject(wrappedValue: AccountDetailViewModel(id: id))
    }
    
    private func amountColor(for amount: Int) -> Color {
        amount >= 0 ? .green : .red
    }
    
    private func transactionColor(for type: TransactionType) -> Color {
        switch type {
        case .deposit:
            return .green
        case .withdrawal:
            return .red
        case .transfer:
            return .purple
        }
    }
    
    private func plusOrMinus(for type: TransactionType) -> String {
        switch type {
        case .deposit:
            return "+"
        case .withdrawal:
            return "-"
        case .transfer:
            return "-"
        }
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading...")
            }
            else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }
            else if let account = viewModel.account {
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("User Name: \(account.user.name)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("User Email: \(account.user.email)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("\(account.amount.formatted()) €")
                        .font(.title2)
                        .foregroundColor(amountColor(for: account.amount))
                    Divider()
                    
                    if viewModel.transactions.isEmpty {
                       Text("No transactions")
                           .foregroundColor(.gray)
                                   
                    }
                    else {
                        List(viewModel.transactions) { transaction in
                            HStack {
                                Text(transaction.transactionType.rawValue.capitalized)
                                    .foregroundColor(transactionColor(for: transaction.transactionType))
                                Spacer()
                                Text("\(plusOrMinus(for: transaction.transactionType)) \(transaction.amount.formatted()) €")
                                    .foregroundColor(transactionColor(for: transaction.transactionType))
                            }
                        }
                        .listStyle(.plain)
                    }
                    
                    Spacer()
                }
                
                .padding()
            }
        }
        .navigationTitle(viewModel.account?.name ?? "Détail")
        .task {
            await viewModel.loadAccount(session: session.self)
            await viewModel.loadTransactions(session: session.self)

        }
    }
}
