//
//  FinancialAccountResponse.swift
//  Auren
//
//  Created by Mattis Lefranc Adam on 29.07.2026.
//

struct FinancialAccountResponse: Identifiable, Codable {
    let id: Int
    let name: String
    let userId: Int
    let amount: Int
    let user: User
}
