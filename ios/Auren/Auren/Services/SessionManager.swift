import Foundation
import Combine
import FirebaseAuth

@MainActor
class SessionManager: ObservableObject {
    @Published var currentUser: User?
    @Published private(set) var firebaseUser: FirebaseAuth.User?
    @Published private(set) var token: String?
    @Published private(set) var isAuthenticated = false

    init() {
        firebaseUser = Auth.auth().currentUser
        isAuthenticated = firebaseUser != nil
    }

    func login(firebaseUser: FirebaseAuth.User, token: String) {
        self.firebaseUser = firebaseUser
        self.token = token
        self.isAuthenticated = true
    }

    func login(user: User, token: String? = nil) {
        self.currentUser = user
        self.token = token
        self.isAuthenticated = true
    }

    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("[Firebase Auth] Sign-out failed: \(error.localizedDescription)")
        }

        currentUser = nil
        firebaseUser = nil
        token = nil
        isAuthenticated = false
    }
}
