//
//  FinancialAccount.swift
//  Auren
//
//  Created by Mattis Lefranc Adam on 29.07.2026.
//


struct FinancialAccount: Codable, Identifiable {
    let id: Int
    let amount: Int
    let userId: Int
    let name: String
    let pinCode: String
}

