//
//  CreateTransactionView.swift
//  Auren
//

import SwiftUI

struct CreateTransactionView: View {
    @StateObject private var viewModel: CreateTransactionViewModel
    @EnvironmentObject var session: SessionManager
    @Environment(\.dismiss) private var dismiss

    init(accountId: Int) {
        _viewModel = StateObject(wrappedValue: CreateTransactionViewModel(accountId: accountId))
    }

    var body: some View {
        Form {
            Section(header: Text("Transaction")) {
                Picker("Type", selection: $viewModel.transactionType) {
                    Text("Deposit").tag(TransactionType.deposit)
                    Text("Withdraw").tag(TransactionType.withdrawal)
                }

                TextField("Amount", text: $viewModel.amountText)
                    .keyboardType(.decimalPad)

                TextField("Comment", text: $viewModel.commentText)

                Picker("Category", selection: $viewModel.categoryTransactionId) {
                    Text("Select a category").tag(nil as Int?)
                    ForEach(viewModel.filteredCategories) { category in
                        Text(category.name).tag(category.id as Int?)
                }
                }
            }

            if let error = viewModel.errorMessage {
                Section {
                    Text(error)
                        .foregroundStyle(Color.aurenNegative)
                        .font(.footnote)
                }
            }

            Section {
                Button {
                    Task {
                        await viewModel.createTransaction()
                        if viewModel.errorMessage == nil {
                            dismiss()
                        }
                    }
                } label: {
                    if viewModel.isLoading {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    } else {
                        Text("Create Transaction")
                            .frame(maxWidth: .infinity)
                    }
                }
                .disabled(viewModel.isLoading)
            }
        }
        .task {
            await viewModel.loadCategories()
        }
        .navigationTitle("New Transaction")
    }
}

#Preview {
    NavigationStack {
        CreateTransactionView(accountId: 1)
    }
    .environmentObject(SessionManager())
}
