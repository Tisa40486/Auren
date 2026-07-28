//
//  CreateAccountViewModel.swift
//  Auren
//
//  Created by Mattis Lefranc Adam on 28.07.2026.
//


import Foundation
import Combine

@MainActor
class CreateAccountViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let apiClient = APIClient.shared

    func createAccount(session: SessionManager) async {
        guard !username.isEmpty, !email.isEmpty, !password.isEmpty else {
            errorMessage = "Merci de remplir tous les champs"
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let payload = CreateAccountRequest(username: username, email: email, password: password)
            let user: User = try await apiClient.request(
                endpoint: "auth/register",
                method: "POST",
                body: payload
            )
            session.login(user: user)
        } catch {
            errorMessage = "Erreur lors de la création du compte"
        }

        isLoading = false
    }
}

struct CreateAccountRequest: Codable {
    let username: String
    let email: String
    let password: String
}