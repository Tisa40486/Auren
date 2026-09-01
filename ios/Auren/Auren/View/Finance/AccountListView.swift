import SwiftUI

struct AccountListView: View {
    @StateObject private var viewModel = AccountListViewModel()
    @State private var navigateToCreateFinancialAccount = false
    @EnvironmentObject private var session: SessionManager
    @EnvironmentObject private var l10n: LocalizationManager

    var body: some View {
        ZStack {
            Color.aurenBackground.ignoresSafeArea()

            content
        }
        .navigationTitle(l10n.tr(.accounts))
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    navigateToCreateFinancialAccount = true
                } label: {
                    Label(l10n.tr(.addAccountButton), systemImage: "plus")
                }
            }
        }
        .navigationDestination(isPresented: $navigateToCreateFinancialAccount) {
            CreateFinancialAccountView()
        }
        .task {
            await viewModel.loadAccounts(session: session)
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView(l10n.tr(.loadingAccounts))
        } else if let error = viewModel.errorMessage {
            ContentUnavailableView(
                l10n.tr(.unableToLoadAccounts),
                systemImage: "exclamationmark.triangle",
                description: Text(error)
            )
        } else if viewModel.accounts.isEmpty {
            ContentUnavailableView {
                Label(l10n.tr(.noAccountsYet), systemImage: "building.columns")
            } description: {
                Text(l10n.tr(.noAccountsDescription))
            } actions: {
                AUButton(title: l10n.tr(.addAccountButton), width: 180) {
                    navigateToCreateFinancialAccount = true
                }
                .padding(.top, 8)
            }
        } else {
            List {
                ForEach(viewModel.accounts) { account in
                    NavigationLink {
                        AccountDetailView(id: account.id)
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(account.name)
                                .font(.headline)
                                .foregroundStyle(Color.aurenTextPrimary)

                            HStack(alignment: .firstTextBaseline, spacing: 3) {
                                Text(account.amount, format: .number.precision(.fractionLength(2)))
                                    .font(.subheadline)
                                    .foregroundStyle(Color.aurenTextSecondary)

                                Text("€")
                                    .font(.subheadline)
                                    .foregroundStyle(Color.aurenGold)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
                .onDelete { indexSet in
                    Task {
                        await viewModel.deleteAccount(at: indexSet, session: session)
                    }
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    NavigationStack {
        AccountListView()
    }
    .environmentObject(SessionManager())
    .environmentObject(LocalizationManager.shared)
}
