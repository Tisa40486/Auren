import Foundation
import Combine

@MainActor
class CreateFinancialAccountViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let apiClient = APIClient.shared

    func createBankAccount(session: SessionManager) async -> Bool {
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = tr(.errFillAllFields)
            return false
        }

        guard let currentUser = session.currentUser else {
            errorMessage = tr(.errUserNotLoggedIn)
            return false
        }

        isLoading = true
        errorMessage = nil

        do {
            let payload = CreateBankAccountRequest(
                name: name,
                userId: currentUser.id,
                amount: 0
            )

            let _: FinancialAccount = try await apiClient.request(
                endpoint: "finance",
                method: "POST",
                body: payload
            )

            isLoading = false
            return true

        } catch {
            print("Bank Create Error: \(error)")

            errorMessage = tr(.errCreateBankAccount)
            isLoading = false

            return false
        }
    }
}

struct CreateBankAccountRequest: Codable {
    let name: String
    let userId: Int
    let amount: Int
}
