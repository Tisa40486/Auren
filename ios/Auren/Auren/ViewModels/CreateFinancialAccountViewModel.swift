import Foundation
import Combine

@MainActor
class CreateFinancialAccountViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var pinCode: String = ""
    @Published var confirm_pinCode: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let apiClient = APIClient.shared

    func createBankAccount(session: SessionManager) async {
        guard !name.isEmpty, !pinCode.isEmpty, !confirm_pinCode.isEmpty else {
            errorMessage = "Please fill in all the fields"
            return
        }
        
        guard let currentUser = session.currentUser else {
            errorMessage = "User not connected"
            return
        }
        isLoading = true
        errorMessage = nil

        do {
            let payload = CreateBankAccountRequest(
                name: name,
                userId: currentUser.id,
                amount: 0,
                pinCode: pinCode,
                confirm_pinCode: confirm_pinCode
            )
            let account: FinancialAccount = try await apiClient.request(
                endpoint: "finance",
                method: "POST",
                body: payload
            )
        }
        catch {
            if let decodingError = error as? DecodingError {
                print("Decoding Error: \(decodingError)")
            } else {
                print("Bank Create Error: \(error)")
            }
            errorMessage = "Incorrect credentials or unknown account"
        }
        isLoading = false
    }
}

struct CreateBankAccountRequest: Codable {
    let name: String
    let userId: Int
    let amount: Int
    let pinCode: String
    let confirm_pinCode: String
}
