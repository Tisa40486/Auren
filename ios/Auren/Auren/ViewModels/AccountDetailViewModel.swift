import Foundation
import Combine

@MainActor
class AccountDetailViewModel: ObservableObject {
    @Published var account: FinancialAccountResponse?
    @Published var transactions: [TransactionResponse] = []
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
            self.transactions = fetchedTransactions
        }
        catch {
           print("Erreur loadAccount: \(error)")
           self.errorMessage = "Erreur : \(error.localizedDescription)"
       }
        isLoading = false
    }
}
