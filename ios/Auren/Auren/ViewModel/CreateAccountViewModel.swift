import Foundation
import Combine

@MainActor
class CreateAccountViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirm_password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let apiClient = APIClient.shared

    func createAccount(session: SessionManager) async {
        guard !username.isEmpty, !email.isEmpty, !password.isEmpty else {
            errorMessage = tr(.errFillAllFields)
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let payload = CreateAccountRequest(
                name: username,
                email: email,
                password: password,
                confirm_password: confirm_password
            )
            let user: User = try await apiClient.request(
                endpoint: "users",
                method: "POST",
                body: payload
            )

            session.login(user: user)
        }
        catch {
            if let decodingError = error as? DecodingError {
                print("Decoding Error: \(decodingError)")
            } else {
                print("Login Error: \(error)")
            }
            errorMessage = tr(.errInvalidCredentials)
        }
        isLoading = false
    }
}

struct CreateAccountRequest: Codable {
    let name: String
    let email: String
    let password: String
    let confirm_password: String
}
