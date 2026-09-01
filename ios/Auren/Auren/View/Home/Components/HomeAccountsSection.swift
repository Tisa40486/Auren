import SwiftUI

struct HomeAccountsSection: View {
    @ObservedObject var viewModel: HomeViewModel
    @EnvironmentObject private var l10n: LocalizationManager
    var onAddAccount: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text(l10n.tr(.myAccounts))
                    .font(.custom("Fraunces", size: 20, relativeTo: .title3))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.aurenTextPrimary)

                Spacer()

                Button(action: onAddAccount) {
                    Label(l10n.tr(.add), systemImage: "plus")
                        .font(.custom("Inter", size: 14, relativeTo: .subheadline))
                        .fontWeight(.medium)
                        .foregroundStyle(Color.aurenGold)
                }
            }

            if viewModel.accounts.isEmpty {
                AUCard {
                    VStack(spacing: 12) {
                        Image(systemName: "building.columns")
                            .font(.system(size: 32))
                            .foregroundStyle(Color.aurenTextSecondary)

                        Text(l10n.tr(.noAccountsConfigured))
                            .font(.subheadline)
                            .foregroundStyle(Color.aurenTextSecondary)

                        AUButton(title: l10n.tr(.addAccountButton), width: 180) {
                            onAddAccount()
                        }
                        .padding(.top, 4)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                }
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(viewModel.accounts) { account in
                            NavigationLink {
                                AccountDetailView(id: account.id)
                            } label: {
                                accountCard(account)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
    }

    private func accountCard(_ account: FinancialAccount) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "building.columns.fill")
                    .font(.subheadline)
                    .foregroundStyle(Color.aurenGold)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundStyle(Color.aurenTextSecondary)
            }

            Spacer()

            VStack(alignment: .leading, spacing: 4) {
                Text(account.name)
                    .font(.custom("Inter", size: 15, relativeTo: .headline))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.aurenTextPrimary)
                    .lineLimit(1)

                HStack(alignment: .firstTextBaseline, spacing: 3) {
                    Text(account.amount, format: .number.precision(.fractionLength(2)))
                        .font(.custom("Inter", size: 17, relativeTo: .body))
                        .fontWeight(.bold)
                        .foregroundStyle(account.amount >= 0 ? Color.aurenTextPrimary : Color.aurenNegative)

                    Text("€")
                        .font(.custom("Inter", size: 14, relativeTo: .caption))
                        .foregroundStyle(Color.aurenGold)
                }
            }
        }
        .padding(16)
        .frame(width: 170, height: 120)
        .background(Color.aurenSurface)
        .overlay {
            RoundedRectangle(cornerRadius: AURadius.medium)
                .stroke(Color.aurenBorder.opacity(0.35), lineWidth: 0.75)
        }
        .clipShape(RoundedRectangle(cornerRadius: AURadius.medium))
    }
}
