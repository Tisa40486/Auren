import Combine
import FirebaseAuth

@MainActor
class CreateAccountViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirm_password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?

    func createAccount(session: SessionManager) async {
        guard !username.isEmpty, !email.isEmpty, !password.isEmpty, !confirm_password.isEmpty else {
            errorMessage = tr(.errFillAllFields)
            return
        }

        guard password == confirm_password else {
            errorMessage = tr(.errInvalidCredentials)
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let result = try await Auth.auth().createUser(
                withEmail: email,
                password: password
            )
            let token = try await result.user.getIDToken()

            session.login(firebaseUser: result.user, token: token)
            print("[Firebase Auth] Account creation successful.")
        } catch {
            print("[Firebase Auth] Account creation failed: \(error.localizedDescription)")
            errorMessage = tr(.errInvalidCredentials)
        }

        isLoading = false
    }
}
