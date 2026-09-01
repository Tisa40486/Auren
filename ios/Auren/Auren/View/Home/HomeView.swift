import SwiftUI

struct HomeView: View {
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var l10n: LocalizationManager
    @StateObject private var viewModel = HomeViewModel()
    @State private var navigateToCreateFinancialAccount = false
    @State private var navigateToSettings = false

    var body: some View {
        ZStack {
            Color.aurenBackground.ignoresSafeArea()

            if viewModel.isLoading && viewModel.accounts.isEmpty {
                ProgressView(l10n.tr(.loadingDashboard))
                    .tint(Color.aurenGold)
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        // Header Greeting
                        if let user = session.currentUser {
                            welcomeHeader(user: user)
                        }

                        // Error Banner if needed
                        if let error = viewModel.errorMessage {
                            errorBanner(error)
                        }

                        // MARK: - Module 1: Finances (Comptes & Flux bancaires)
                        financeSection

                        // MARK: - Module 2: Emplacement pour futurs modules non bancaires
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
                .refreshable {
                    await reloadData()
                }
            }
        }
        .task {
            await reloadData()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    session.logout()
                } label: {
                    Label(l10n.tr(.logOut), systemImage: "rectangle.portrait.and.arrow.right")
                        .foregroundStyle(Color.aurenNegative)
                }
            }

            ToolbarItem(placement: .primaryAction) {
                Button {
                    navigateToSettings = true
                } label: {
                    Label(l10n.tr(.settings), systemImage: "gearshape.fill")
                        .foregroundStyle(Color.aurenTextSecondary)
                }
            }
        }
        .navigationDestination(isPresented: $navigateToCreateFinancialAccount) {
            CreateFinancialAccountView()
        }
        .navigationDestination(isPresented: $navigateToSettings) {
            SettingsView()
        }
    }

    // MARK: - Subviews

    private func welcomeHeader(user: User) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(Date.now, format: .dateTime.weekday(.wide).day().month(.wide))
                .font(.custom("Inter", size: 13, relativeTo: .caption))
                .textCase(.uppercase)
                .foregroundStyle(Color.aurenTextSecondary)

            Text(l10n.tr(.greeting(user.name)))
                .font(.custom("Fraunces", size: 28, relativeTo: .title))
                .fontWeight(.bold)
                .foregroundStyle(Color.aurenTextPrimary)
        }
        .padding(.top, 4)
    }

    private var financeSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Financial Summary & Pie Chart
            FinancialChartCard(viewModel: viewModel)

            // Bank Accounts Section
            HomeAccountsSection(viewModel: viewModel) {
                navigateToCreateFinancialAccount = true
            }

            // Recent Transactions
            HomeRecentTransactionsSection(viewModel: viewModel)
        }
    }

    private func errorBanner(_ message: String) -> some View {
        HStack(spacing: 10) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundStyle(Color.aurenNegative)

            Text(message)
                .font(.caption)
                .foregroundStyle(Color.aurenTextPrimary)

            Spacer()

            Button(l10n.tr(.retry)) {
                Task {
                    await reloadData()
                }
            }
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundStyle(Color.aurenGold)
        }
        .padding(12)
        .background(Color.aurenNegative.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: AURadius.small))
    }

    private func reloadData() async {
        if let user = session.currentUser, let token = session.token {
            await viewModel.loadDashboard(userId: user.id, token: token)
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .environmentObject(SessionManager())
    .environmentObject(LocalizationManager.shared)
}
