import SwiftUI

struct AccountListView: View {
    @StateObject private var viewModel = AccountListViewModel()
    @State private var navigateToCreateFinancialAccount = false

    @EnvironmentObject private var session: SessionManager

    var body: some View {
        ZStack {
            Color.aurenBackground.ignoresSafeArea()

            content
        }
        .navigationTitle("Accounts")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    navigateToCreateFinancialAccount = true
                } label: {
                    Label("Add Account", systemImage: "plus")
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
            ProgressView("Loading accounts…")
        } else if let error = viewModel.errorMessage {
            ContentUnavailableView(
                "Unable to Load Accounts",
                systemImage: "exclamationmark.triangle",
                description: Text(error)
            )
        } else if viewModel.accounts.isEmpty {
            ContentUnavailableView {
                Label("No Accounts Yet", systemImage: "building.columns")
            } description: {
                Text("Create an account to start tracking your finances.")
            } actions: {
                AUButton(title: "Add Account", width: 200) {
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

                            Text(account.amount, format: .number.precision(.fractionLength(2)))
                                .font(.subheadline)
                                .foregroundStyle(Color.aurenTextSecondary)
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
}
