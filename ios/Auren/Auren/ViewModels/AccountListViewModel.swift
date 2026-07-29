import Foundation
import Combine

@MainActor
class AccountListViewModel: ObservableObject {
    @Published var accounts: [FinancialAccount] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    var hasAccount: Bool {
        !accounts.isEmpty
    }

    private let apiClient = APIClient.shared

    func loadAccounts(session: SessionManager) async {
        guard let user = session.currentUser, let token = session.token else {
            errorMessage = "User not logged."
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let fetchedAccounts: [FinancialAccount] = try await apiClient.request(
                endpoint: "finance/user/\(user.id)",
                method: "GET",
                token: token
            )
            self.accounts = fetchedAccounts
        } catch {
            print("Erreur loadAccounts: \(error)")
            self.errorMessage = "Erreur : \(error.localizedDescription)"
        }

        isLoading = false
    }
}
