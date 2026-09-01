import Foundation
import Combine

@MainActor
class AccountDetailViewModel: ObservableObject {
    @Published var account: FinancialAccountResponse?
    @Published var transactions: [TransactionResponse] = []
    @Published var allCategories: [CategoryTransaction] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let apiClient = APIClient.shared
    private let id: Int

    init(id: Int) {
        self.id = id
    }

    func loadAccount(session: SessionManager) async {
        isLoading = true
        errorMessage = nil

        do {
            let fetchedAccount: FinancialAccountResponse = try await apiClient.request(
                endpoint: "finance/\(id)",
                method: "GET",
                token: session.token
            )
            self.account = fetchedAccount
        } catch {
            print("Erreur loadAccount: \(error)")
            self.errorMessage = tr(.errLoadAccounts)
        }

        isLoading = false
    }

    func loadTransactions(session: SessionManager) async {
        isLoading = true
        errorMessage = nil

        do {
            let fetchedTransactions: [TransactionResponse] = try await apiClient.request(
                endpoint: "transaction/\(self.id)",
                method: "GET",
                token: session.token
            )
            self.transactions = fetchedTransactions.reversed()
        }
        catch {
           print("Erreur loadTransactions: \(error)")
           self.errorMessage = tr(.errLoadTransactions)
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
            self.errorMessage = tr(.errLoadCategories)
        }
    }

    func category(for id: Int) -> CategoryTransaction? {
        allCategories.first { $0.id == id }
    }
}
