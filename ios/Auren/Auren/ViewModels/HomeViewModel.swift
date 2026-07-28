//
//  HomeViewModel.swift
//  Auren
//
//  Created by Mattis Lefranc Adam on 28.07.2026.
//


import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var hasAccount: Bool = false

    private let apiClient = APIClient.shared

    func checkAccount(userId: Int) async {
        isLoading = true
        do {
            let _: Account = try await apiClient.request(endpoint: "accounts/\(userId)")
            hasAccount = true
        } catch {
            hasAccount = false
        }
        isLoading = false
    }
}