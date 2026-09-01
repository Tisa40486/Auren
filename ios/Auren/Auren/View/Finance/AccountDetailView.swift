import SwiftUI

struct AccountDetailView: View {
    @StateObject private var viewModel: AccountDetailViewModel
    @EnvironmentObject private var session: SessionManager
    @EnvironmentObject private var l10n: LocalizationManager
    @State private var navigateToCreateTransaction = false

    init(id: Int) {
        _viewModel = StateObject(wrappedValue: AccountDetailViewModel(id: id))
    }

    var body: some View {
        ZStack {
            Color.aurenBackground.ignoresSafeArea()

            if viewModel.isLoading {
                ProgressView(l10n.tr(.loading))
            } else if let error = viewModel.errorMessage {
                ContentUnavailableView(
                    l10n.tr(.unableToLoadAccounts),
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

                                HStack(alignment: .firstTextBaseline, spacing: 4) {
                                    Text(account.amount, format: .number.precision(.fractionLength(2)))
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(amountColor(for: account.amount))

                                    Text("€")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color.aurenGold)
                                }

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
        .navigationTitle(l10n.tr(.account))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    navigateToCreateTransaction = true
                } label: {
                    Label(l10n.tr(.addTransaction), systemImage: "plus")
                }
            }
        }
        .task {
            await viewModel.loadAccount(session: session)
            await viewModel.loadTransactions(session: session)
            await viewModel.loadCategories(session: session)
        }
        .navigationDestination(isPresented: $navigateToCreateTransaction) {
            if let account = viewModel.account {
                CreateTransactionView(accountId: account.id)
            }
        }
    }

    private var transactionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(l10n.tr(.transactions))
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(Color.aurenTextPrimary)

            if viewModel.transactions.isEmpty {
                ContentUnavailableView(
                    l10n.tr(.noTransactions),
                    systemImage: "arrow.left.arrow.right",
                    description: Text(l10n.tr(.noTransactionsDescription))
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
                Text(transactionTypeTitle(transaction.transactionType))
                    .font(.headline)
                    .foregroundStyle(transactionColor(for: transaction.transactionType))

                Spacer()

                Text("\(amountPrefix(for: transaction.transactionType))\(transaction.amount.formatted()) €")
                    .fontWeight(.semibold)
                    .foregroundStyle(transactionColor(for: transaction.transactionType))
            }

            Text(transaction.comment.isEmpty ? l10n.tr(.noComment) : transaction.comment)
                .font(.subheadline)
                .foregroundStyle(Color.aurenTextSecondary)

            HStack {
                CategoryChip(
                    name: viewModel.category(for: transaction.categoryId)?.name ?? l10n.tr(.unknown),
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

    private func transactionTypeTitle(_ type: TransactionType) -> String {
        switch type {
        case .deposit: return l10n.tr(.deposit)
        case .withdrawal: return l10n.tr(.withdrawal)
        case .transfer: return l10n.tr(.transfer)
        }
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
    .environmentObject(LocalizationManager.shared)
}
