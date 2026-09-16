import Combine
import FirebaseAuth

@MainActor
class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?

    func login(session: SessionManager) async {
        guard !username.isEmpty, !password.isEmpty else {
            errorMessage = tr(.errFillAllFields)
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let result = try await Auth.auth().signIn(
                withEmail: username,
                password: password
            )
            let token = try await result.user.getIDToken()

            session.login(firebaseUser: result.user, token: token)
            print("[Firebase Auth] Sign-in successful.")
        } catch {
            print("[Firebase Auth] Sign-in failed: \(error.localizedDescription)")
            errorMessage = tr(.errInvalidCredentials)
        }

        isLoading = false
    }
}
