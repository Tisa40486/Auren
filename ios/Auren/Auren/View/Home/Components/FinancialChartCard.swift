import SwiftUI
import Charts

enum ChartDisplayMode: Int, CaseIterable, Identifiable {
    case cashFlow = 0
    case categories = 1

    var id: Int { rawValue }

    func title(using l10n: LocalizationManager) -> String {
        switch self {
        case .cashFlow:
            return l10n.tr(.cashFlow)
        case .categories:
            return l10n.tr(.byCategory)
        }
    }
}

struct FinancialChartCard: View {
    @ObservedObject var viewModel: HomeViewModel
    @EnvironmentObject private var l10n: LocalizationManager
    @State private var selectedMode: ChartDisplayMode = .cashFlow

    var body: some View {
        AUCard {
            VStack(alignment: .leading, spacing: 20) {
                // Header: Total Balance & Mode Picker
                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(l10n.tr(.totalBalance))
                                .font(.custom("Inter", size: 14, relativeTo: .subheadline))
                                .foregroundStyle(Color.aurenTextSecondary)

                            HStack(alignment: .firstTextBaseline, spacing: 4) {
                                Text(viewModel.totalBalance, format: .number.precision(.fractionLength(2)))
                                    .font(.custom("Fraunces", size: 30, relativeTo: .title))
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.aurenTextPrimary)
                                Text("€")
                                    .font(.custom("Fraunces", size: 22, relativeTo: .title2))
                                    .foregroundStyle(Color.aurenGold)
                            }
                        }

                        Spacer()

                        Picker("Mode", selection: $selectedMode) {
                            ForEach(ChartDisplayMode.allCases) { mode in
                                Text(mode.title(using: l10n)).tag(mode)
                            }
                        }
                        .pickerStyle(.segmented)
                        .frame(maxWidth: 190)
                    }

                    // Inflow & Outflow badges
                    HStack(spacing: 12) {
                        flowBadge(
                            title: l10n.tr(.income),
                            amount: viewModel.totalIncome,
                            prefix: "+",
                            color: .aurenPositive,
                            icon: "arrow.down.left"
                        )

                        flowBadge(
                            title: l10n.tr(.expenses),
                            amount: viewModel.totalExpense,
                            prefix: "−",
                            color: .aurenNegative,
                            icon: "arrow.up.right"
                        )
                    }
                }

                Divider()
                    .background(Color.aurenBorder.opacity(0.3))

                // Chart Section
                if selectedMode == .cashFlow {
                    cashFlowChartSection
                } else {
                    categoryBreakdownChartSection
                }
            }
        }
    }

    // MARK: - Cash Flow Chart (Income vs Expenses)

    @ViewBuilder
    private var cashFlowChartSection: some View {
        let slices = localizedCashFlowSlices
        if slices.isEmpty {
            emptyChartPlaceholder(message: l10n.tr(.noTransactionsChart))
        } else {
            VStack(spacing: 16) {
                ZStack {
                    Chart(slices) { slice in
                        SectorMark(
                            angle: .value("Montant", slice.amount),
                            innerRadius: .ratio(0.68),
                            angularInset: 2.5
                        )
                        .cornerRadius(6)
                        .foregroundStyle(slice.color)
                    }
                    .frame(height: 200)

                    // Center information
                    VStack(spacing: 2) {
                        Text(l10n.tr(.netFlow))
                            .font(.caption2)
                            .fontWeight(.medium)
                            .foregroundStyle(Color.aurenTextSecondary)

                        let net = viewModel.netFlow
                        Text("\(net >= 0 ? "+" : "")\(net.formatted(.number.precision(.fractionLength(2)))) €")
                            .font(.custom("Inter", size: 14, relativeTo: .body))
                            .fontWeight(.bold)
                            .foregroundStyle(net >= 0 ? Color.aurenPositive : Color.aurenNegative)
                    }
                }

                // Legend
                VStack(spacing: 8) {
                    ForEach(slices) { slice in
                        let total = viewModel.totalCashFlow
                        let pct = total > 0 ? (slice.amount / total) * 100 : 0
                        HStack {
                            Circle()
                                .fill(slice.color)
                                .frame(width: 10, height: 10)

                            Text(slice.name)
                                .font(.subheadline)
                                .foregroundStyle(Color.aurenTextPrimary)

                            Spacer()

                            Text("\(slice.amount.formatted(.number.precision(.fractionLength(2)))) €")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.aurenTextPrimary)

                            Text(String(format: "(%.1f%%)", pct))
                                .font(.caption)
                                .foregroundStyle(Color.aurenTextSecondary)
                                .frame(width: 50, alignment: .trailing)
                        }
                    }
                }
                .padding(.top, 4)
            }
        }
    }

    // MARK: - Category Breakdown Chart

    @ViewBuilder
    private var categoryBreakdownChartSection: some View {
        if viewModel.expenseCategoryBreakdown.isEmpty {
            emptyChartPlaceholder(message: l10n.tr(.noCategoryExpenses))
        } else {
            VStack(spacing: 16) {
                ZStack {
                    Chart(viewModel.expenseCategoryBreakdown) { slice in
                        SectorMark(
                            angle: .value("Montant", slice.amount),
                            innerRadius: .ratio(0.68),
                            angularInset: 2.5
                        )
                        .cornerRadius(6)
                        .foregroundStyle(slice.color)
                    }
                    .frame(height: 200)

                    // Center information
                    VStack(spacing: 2) {
                        Text(l10n.tr(.totalExpenses))
                            .font(.caption2)
                            .fontWeight(.medium)
                            .foregroundStyle(Color.aurenTextSecondary)

                        Text("\(viewModel.totalExpense.formatted(.number.precision(.fractionLength(2)))) €")
                            .font(.custom("Inter", size: 14, relativeTo: .body))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.aurenNegative)
                    }
                }

                // Category list breakdown
                VStack(spacing: 10) {
                    ForEach(viewModel.expenseCategoryBreakdown) { slice in
                        HStack(spacing: 8) {
                            Image(systemName: slice.icon)
                                .font(.caption)
                                .foregroundStyle(slice.color)
                                .frame(width: 20, height: 20)
                                .background(slice.color.opacity(0.15))
                                .clipShape(Circle())

                            Text(slice.name)
                                .font(.subheadline)
                                .foregroundStyle(Color.aurenTextPrimary)

                            Spacer()

                            Text("\(slice.amount.formatted(.number.precision(.fractionLength(2)))) €")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.aurenTextPrimary)

                            Text(String(format: "%.0f%%", slice.percentage))
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundStyle(Color.aurenTextSecondary)
                                .frame(width: 38, alignment: .trailing)
                        }
                    }
                }
                .padding(.top, 4)
            }
        }
    }

    // MARK: - Helpers

    private var localizedCashFlowSlices: [CashFlowSlice] {
        var slices: [CashFlowSlice] = []
        if viewModel.totalIncome > 0 {
            slices.append(CashFlowSlice(
                type: .income,
                name: l10n.tr(.income),
                amount: viewModel.totalIncome,
                color: Color.aurenPositive
            ))
        }
        if viewModel.totalExpense > 0 {
            slices.append(CashFlowSlice(
                type: .expense,
                name: l10n.tr(.expenses),
                amount: viewModel.totalExpense,
                color: Color.aurenNegative
            ))
        }
        return slices
    }

    private func flowBadge(title: String, amount: Double, prefix: String, color: Color, icon: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundStyle(color)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption2)
                    .foregroundStyle(Color.aurenTextSecondary)

                Text("\(prefix)\(amount.formatted(.number.precision(.fractionLength(2)))) €")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(color)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(color.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: AURadius.small))
    }

    private func emptyChartPlaceholder(message: String) -> some View {
        VStack(spacing: 10) {
            Image(systemName: "chart.pie")
                .font(.system(size: 36))
                .foregroundStyle(Color.aurenTextSecondary.opacity(0.6))
                .padding(.top, 8)

            Text(message)
                .font(.subheadline)
                .foregroundStyle(Color.aurenTextSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
    }
}
