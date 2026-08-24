import Foundation
import Combine

@MainActor
class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let apiClient = APIClient.shared

    func login(session: SessionManager) async {
        guard !username.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill all the fields"
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let tokenResponse: TokenResponse = try await apiClient.request(
                endpoint: "auth/login",
                method: "POST",
                formBody: ["username": username, "password": password]
            )

            let user: User = try await apiClient.request(
                endpoint: "auth/me",
                method: "GET",
                token: tokenResponse.access_token
            )

            session.login(user: user, token: tokenResponse.access_token)
        }
        catch {
            if let decodingError = error as? DecodingError {
                print("Decoding Error:\(decodingError)")
            } else {
                print("Login Error: \(error)")
            }
            errorMessage = "Incorrect credentials or unknown user"
        }
        isLoading = false
    }
}

struct LoginRequest: Codable {
    let username: String
    let password: String
}

struct TokenResponse: Codable {
    let access_token: String
    let token_type: String
}
