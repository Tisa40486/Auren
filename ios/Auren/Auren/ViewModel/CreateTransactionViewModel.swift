import Foundation
import Combine

@MainActor
class CreateTransactionViewModel: ObservableObject {
    private let accountId: Int

    @Published var amountText: String = ""
    @Published var commentText: String = ""
    @Published var categoryTransactionId: Int?
    @Published var transactionType: TransactionType = .deposit
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var lastTransaction: TransactionResponse?
    @Published var allCategories: [CategoryTransaction] = []

    private let apiClient = APIClient.shared

    init(accountId: Int) {
        self.accountId = accountId
    }

    var filteredCategories: [CategoryTransaction] {
        allCategories.filter { category in
            switch transactionType {
            case .deposit:
                return category.type == .income
            case .withdrawal:
                return category.type == .expense
            case .transfer:
                return category.type == .expense || category.type == .income
            }
        }
    }

    func createTransaction(session: SessionManager) async {
        guard !amountText.isEmpty else {
            errorMessage = tr(.errEnterAmount)
            return
        }

        guard let amount = Double(amountText.replacingOccurrences(of: ",", with: ".")), amount > 0 else {
            errorMessage = tr(.errInvalidAmount)
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let payload = CreateTransactionRequest(
                accountId: accountId,
                amount: amount,
                transactionType: transactionType,
                comment: commentText,
                categoryId: categoryTransactionId
            )
            let transaction: TransactionResponse = try await apiClient.request(
                endpoint: "transaction",
                method: "POST",
                body: payload,
                token: session.token
            )
            lastTransaction = transaction
            amountText = ""
        }
        catch {
            if let decodingError = error as? DecodingError {
                print("Decoding Error: \(decodingError)")
            } else {
                print("Transaction Create Error: \(error)")
            }
            errorMessage = tr(.errCreateTransaction)
        }

        isLoading = false
    }

    func loadCategories(session: SessionManager) async {
        do {
            let categories: [CategoryTransaction] = try await apiClient.request(
                endpoint: "transaction/categories",
                method: "GET",
                token: session.token
            )
            self.allCategories = categories
        } catch {
            print("Load Categories Error: \(error.localizedDescription)")
            errorMessage = tr(.errLoadCategories)
        }
    }
}

struct CreateTransactionRequest: Codable {
    let accountId: Int
    let amount: Double
    let transactionType: TransactionType
    let comment: String
    let categoryId: Int?
}
