import SwiftUI

struct CreateTransactionView: View {
    @StateObject private var viewModel: CreateTransactionViewModel
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject private var l10n: LocalizationManager
    @Environment(\.dismiss) private var dismiss

    init(accountId: Int) {
        _viewModel = StateObject(wrappedValue: CreateTransactionViewModel(accountId: accountId))
    }

    var body: some View {
        Form {
            Section(header: Text(l10n.tr(.transaction))) {
                Picker(l10n.tr(.type), selection: $viewModel.transactionType) {
                    Text(l10n.tr(.deposit)).tag(TransactionType.deposit)
                    Text(l10n.tr(.withdrawal)).tag(TransactionType.withdrawal)
                }

                TextField(l10n.tr(.amount), text: $viewModel.amountText)
                    .keyboardType(.decimalPad)

                TextField(l10n.tr(.comment), text: $viewModel.commentText)

                Picker(l10n.tr(.category), selection: $viewModel.categoryTransactionId) {
                    Text(l10n.tr(.selectCategory)).tag(nil as Int?)
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
                        await viewModel.createTransaction(session: session)
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
                        Text(l10n.tr(.createTransactionButton))
                            .frame(maxWidth: .infinity)
                    }
                }
                .disabled(viewModel.isLoading)
            }
        }
        .task {
            await viewModel.loadCategories(session: session)
        }
        .navigationTitle(l10n.tr(.newTransaction))
    }
}

#Preview {
    NavigationStack {
        CreateTransactionView(accountId: 1)
    }
    .environmentObject(SessionManager())
    .environmentObject(LocalizationManager.shared)
}
