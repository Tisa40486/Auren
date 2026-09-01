import Foundation
import Combine
import SwiftUI

struct CashFlowSlice: Identifiable {
    enum FlowType {
        case income, expense
    }
    var id: String { name }
    let type: FlowType
    let name: String
    let amount: Double
    let color: Color
}

struct CategoryBreakdownSlice: Identifiable {
    let id: Int
    let name: String
    let amount: Double
    let percentage: Double
    let color: Color
    let icon: String
}

@MainActor
class HomeViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var accounts: [FinancialAccount] = []
    @Published var transactions: [TransactionResponse] = []
    @Published var categories: [CategoryTransaction] = []
    @Published var errorMessage: String?

    private let apiClient = APIClient.shared

    var hasAccount: Bool {
        !accounts.isEmpty
    }

    var totalBalance: Double {
        accounts.reduce(0) { $0 + $1.amount }
    }

    var totalIncome: Double {
        transactions
            .filter { $0.transactionType == .deposit }
            .reduce(0) { $0 + $1.amount }
    }

    var totalExpense: Double {
        transactions
            .filter { $0.transactionType == .withdrawal }
            .reduce(0) { $0 + $1.amount }
    }

    var netFlow: Double {
        totalIncome - totalExpense
    }

    var totalCashFlow: Double {
        totalIncome + totalExpense
    }

    func category(for id: Int) -> CategoryTransaction? {
        categories.first { $0.id == id }
    }

    // Cash flow chart data (Income vs Expenses)
    var cashFlowChartData: [CashFlowSlice] {
        var slices: [CashFlowSlice] = []
        if totalIncome > 0 {
            slices.append(CashFlowSlice(
                type: .income,
                name: tr(.income),
                amount: totalIncome,
                color: Color.aurenPositive
            ))
        }
        if totalExpense > 0 {
            slices.append(CashFlowSlice(
                type: .expense,
                name: tr(.expenses),
                amount: totalExpense,
                color: Color.aurenNegative
            ))
        }
        return slices
    }

    // Category breakdown for expenses
    var expenseCategoryBreakdown: [CategoryBreakdownSlice] {
        let expenseTransactions = transactions.filter { $0.transactionType == .withdrawal }
        var grouped: [Int: Double] = [:]
        for tx in expenseTransactions {
            grouped[tx.categoryId, default: 0] += tx.amount
        }

        let total = totalExpense > 0 ? totalExpense : 1.0

        return grouped.compactMap { categoryId, amount in
            let cat = category(for: categoryId)
            let name = cat?.name ?? tr(.unknown)
            let colorHex = cat?.color ?? "8A867D"
            let icon = cat?.icon ?? "tag.fill"
            let percentage = (amount / total) * 100
            return CategoryBreakdownSlice(
                id: categoryId,
                name: name,
                amount: amount,
                percentage: percentage,
                color: Color(hex: colorHex),
                icon: icon
            )
        }
        .sorted { $0.amount > $1.amount }
    }

    // Recent transactions (most recent 5)
    var recentTransactions: [TransactionResponse] {
        Array(transactions.prefix(5))
    }

    func loadDashboard(userId: Int, token: String) async {
        isLoading = true
        errorMessage = nil

        do {
            async let fetchedAccounts: [FinancialAccount] = apiClient.request(
                endpoint: "finance/user/\(userId)",
                method: "GET",
                token: token
            )
            async let fetchedCategories: [CategoryTransaction] = apiClient.request(
                endpoint: "transaction/categories",
                method: "GET",
                token: token
            )

            let (accs, cats) = try await (fetchedAccounts, fetchedCategories)
            self.accounts = accs
            self.categories = cats

            // Load transactions for all accounts concurrently
            var allTx: [TransactionResponse] = []
            for account in accs {
                do {
                    let txs: [TransactionResponse] = try await apiClient.request(
                        endpoint: "transaction/\(account.id)",
                        method: "GET",
                        token: token
                    )
                    allTx.append(contentsOf: txs)
                } catch {
                    print("Error loading transactions for account \(account.id): \(error)")
                }
            }

            self.transactions = allTx.sorted { $0.createdAt > $1.createdAt }
        } catch {
            print("Erreur loadDashboard: \(error)")
            errorMessage = tr(.errLoadAccounts)
        }

        isLoading = false
    }
}
