import SwiftUI

struct AccountDetailView: View {
    @StateObject private var viewModel: AccountDetailViewModel
    @EnvironmentObject private var session: SessionManager
    @State private var navigateToCreateTransaction = false

    init(id: Int) {
        _viewModel = StateObject(wrappedValue: AccountDetailViewModel(id: id))
    }

    var body: some View {
        ZStack {
            Color.aurenBackground.ignoresSafeArea()

            if viewModel.isLoading {
                ProgressView("Loading account…")
            } else if let error = viewModel.errorMessage {
                ContentUnavailableView(
                    "Unable to Load Account",
                    systemImage: "exclamationmark.triangle",
                    description: Text(error)
                )
            } else if let account = viewModel.account {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        AUCard {
                            VStack(alignment: .leading, spacing: 12) {
                                Text(account.name)
                                    .font(.custom("Fraunces", size: 34, relativeTo: .title))
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.aurenTextPrimary)

                                Text(account.amount, format: .number.precision(.fractionLength(2)))
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(amountColor(for: account.amount))

                                Label(account.user.email, systemImage: "person.crop.circle")
                                    .font(.subheadline)
                                    .foregroundStyle(Color.aurenTextSecondary)
                            }
                        }

                        transactionsSection
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Account")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    navigateToCreateTransaction = true
                } label: {
                    Label("Add Transaction", systemImage: "plus")
                }
            }
        }
        .task {
            await viewModel.loadAccount(session: session)
            await viewModel.loadTransactions(session: session)
            await viewModel.loadCategories()
        }
        .navigationDestination(isPresented: $navigateToCreateTransaction) {
            if let account = viewModel.account {
                CreateTransactionView(accountId: account.id)
            }
        }
    }

    private var transactionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Transactions")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(Color.aurenTextPrimary)

            if viewModel.transactions.isEmpty {
                ContentUnavailableView(
                    "No Transactions",
                    systemImage: "arrow.left.arrow.right",
                    description: Text("Transactions you add will appear here.")
                )
                .frame(maxWidth: .infinity)
                .padding(.vertical, 32)
            } else {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.transactions) { transaction in
                        transactionRow(transaction)
                    }
                }
            }
        }
    }

    private func transactionRow(_ transaction: TransactionResponse) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(transaction.transactionType.rawValue.capitalized)
                    .font(.headline)
                    .foregroundStyle(transactionColor(for: transaction.transactionType))

                Spacer()

                Text("\(amountPrefix(for: transaction.transactionType))\(transaction.amount.formatted()) €")
                    .fontWeight(.semibold)
                    .foregroundStyle(transactionColor(for: transaction.transactionType))
            }

            Text(transaction.comment.isEmpty ? "No comment" : transaction.comment)
                .font(.subheadline)
                .foregroundStyle(Color.aurenTextSecondary)

            HStack {
                CategoryChip(
                    name: viewModel.category(for: transaction.categoryId)?.name ?? "Unknown",
                    icon: viewModel.category(for: transaction.categoryId)?.icon ?? "questionmark.circle",
                    colorHex: viewModel.category(for: transaction.categoryId)?.color ?? "8A867D"
                )

                Spacer()

                Text(transaction.createdAt, format: .dateTime.year().month().day())
                    .font(.caption)
                    .foregroundStyle(Color.aurenTextSecondary)
            }
        }
        .padding(16)
        .background(Color.aurenSurface, in: RoundedRectangle(cornerRadius: AURadius.medium))
    }

    private func amountColor(for amount: Double) -> Color {
        amount >= 0 ? .aurenPositive : .aurenNegative
    }

    private func transactionColor(for type: TransactionType) -> Color {
        switch type {
        case .deposit:
            .aurenPositive
        case .withdrawal:
            .aurenNegative
        case .transfer:
            .aurenBronze
        }
    }

    private func amountPrefix(for type: TransactionType) -> String {
        type == .deposit ? "+" : "−"
    }
}

#Preview {
    NavigationStack {
        AccountDetailView(id: 1)
    }
    .environmentObject(SessionManager())
}
