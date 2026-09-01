import SwiftUI

struct HomeRecentTransactionsSection: View {
    @ObservedObject var viewModel: HomeViewModel
    @EnvironmentObject private var l10n: LocalizationManager

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(l10n.tr(.recentTransactions))
                .font(.custom("Fraunces", size: 20, relativeTo: .title3))
                .fontWeight(.bold)
                .foregroundStyle(Color.aurenTextPrimary)

            if viewModel.recentTransactions.isEmpty {
                AUCard {
                    VStack(spacing: 8) {
                        Image(systemName: "arrow.left.arrow.right")
                            .font(.system(size: 28))
                            .foregroundStyle(Color.aurenTextSecondary)

                        Text(l10n.tr(.noRecentTransactions))
                            .font(.subheadline)
                            .foregroundStyle(Color.aurenTextSecondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                }
            } else {
                VStack(spacing: 10) {
                    ForEach(viewModel.recentTransactions) { transaction in
                        transactionRow(transaction)
                    }
                }
            }
        }
    }

    private func transactionRow(_ transaction: TransactionResponse) -> some View {
        let category = viewModel.category(for: transaction.categoryId)
        let isDeposit = transaction.transactionType == .deposit

        return HStack(spacing: 12) {
            // Category icon
            Image(systemName: category?.icon ?? (isDeposit ? "arrow.down.left" : "arrow.up.right"))
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(category != nil ? Color(hex: category!.color) : (isDeposit ? Color.aurenPositive : Color.aurenNegative))
                .frame(width: 36, height: 36)
                .background(
                    (category != nil ? Color(hex: category!.color) : (isDeposit ? Color.aurenPositive : Color.aurenNegative))
                        .opacity(0.15)
                )
                .clipShape(Circle())

            // Description and category name
            VStack(alignment: .leading, spacing: 3) {
                Text(transaction.comment.isEmpty ? (category?.name ?? (isDeposit ? l10n.tr(.deposit) : l10n.tr(.withdrawal))) : transaction.comment)
                    .font(.custom("Inter", size: 14, relativeTo: .body))
                    .fontWeight(.medium)
                    .foregroundStyle(Color.aurenTextPrimary)
                    .lineLimit(1)

                Text(transaction.createdAt, format: .dateTime.day().month(.abbreviated))
                    .font(.caption2)
                    .foregroundStyle(Color.aurenTextSecondary)
            }

            Spacer()

            // Amount
            Text("\(isDeposit ? "+" : "−")\(transaction.amount.formatted(.number.precision(.fractionLength(2)))) €")
                .font(.custom("Inter", size: 14, relativeTo: .body))
                .fontWeight(.semibold)
                .foregroundStyle(isDeposit ? Color.aurenPositive : Color.aurenNegative)
        }
        .padding(12)
        .background(Color.aurenSurface)
        .overlay {
            RoundedRectangle(cornerRadius: AURadius.medium)
                .stroke(Color.aurenBorder.opacity(0.2), lineWidth: 0.75)
        }
        .clipShape(RoundedRectangle(cornerRadius: AURadius.medium))
    }
}
