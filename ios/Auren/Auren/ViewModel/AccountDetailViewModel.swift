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
            self.errorMessage = "Erreur : \(error.localizedDescription)"
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
           print("Erreur loadAccount: \(error)")
           self.errorMessage = "Erreur : \(error.localizedDescription)"
       }
        isLoading = false
    }
    func loadCategories() async {
        do {
            let categories: [CategoryTransaction] = try await apiClient.request(
                endpoint: "transaction/categories",
                method: "GET"
            )
            self.allCategories = categories
        } catch {
            print("Load Categories Error: \(error)")
        }
    }
    
    func category(for id: Int) -> CategoryTransaction? {
        allCategories.first { $0.id == id }
    }
}
