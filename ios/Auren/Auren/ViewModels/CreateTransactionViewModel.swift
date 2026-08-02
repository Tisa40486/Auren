import Foundation
import Combine

@MainActor
class CreateTransactionViewModel: ObservableObject {
    private let accountId: Int

    @Published var amountText: String = ""
    @Published var transactionType: TransactionType = .deposit
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var lastTransaction: Transaction?

    private let apiClient = APIClient.shared

    init(accountId: Int) {
        self.accountId = accountId
    }

    func createTransaction() async {
        guard !amountText.isEmpty else {
            errorMessage = "Please enter an amount"
            return
        }

        guard let amount = Double(amountText), amount > 0 else {
            errorMessage = "Invalid amount"
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let payload = CreateTransactionRequest(
                accountId: accountId,
                amount: amount,
                transactionType: transactionType
            )
            let transaction: Transaction = try await apiClient.request(
                endpoint: "transaction",
                method: "POST",
                body: payload
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
            errorMessage = "Failed to create transaction"
        }

        isLoading = false
    }
}

struct Transaction: Codable, Identifiable {
    let id: Int
    let amount: Double
    let createdAt: Date
    let transactionType: TransactionType
    let accountId: Int
}

struct CreateTransactionRequest: Codable {
    let accountId: Int
    let amount: Double
    let transactionType: TransactionType
}
