//
//  SessionManager.swift
//  Auren
//
//  Created by Mattis Lefranc Adam on 28.07.2026.
//

import Foundation
import Combine

@MainActor
class SessionManager: ObservableObject {
    @Published var currentUser: User?
    @Published var token: String?
    @Published var isAuthenticated: Bool = false

    func login(user: User, token: String? = nil) {
        self.currentUser = user
        self.token = token
        self.isAuthenticated = true
    }

    func logout() {
        self.currentUser = nil
        self.token = nil
        self.isAuthenticated = false
    }
}
