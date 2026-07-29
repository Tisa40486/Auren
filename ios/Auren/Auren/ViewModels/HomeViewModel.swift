import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var hasAccount: Bool = false
    @Published var errorMessage: String?

    private let apiClient = APIClient.shared

    func checkAccount(userId: Int, token: String) async {
        isLoading = true
        errorMessage = nil

        do {
            let accounts: [FinancialAccount] = try await apiClient.request(
                endpoint: "finance/user/\(userId)",
                method: "GET",
                token: token
            )
            hasAccount = !accounts.isEmpty
        } catch {
            print("Erreur checkAccount: \(error)")
            errorMessage = "Impossible de vérifier les comptes"
        }

        isLoading = false
    }
}
