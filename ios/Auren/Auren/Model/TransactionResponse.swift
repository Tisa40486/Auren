//
//  TransactionResponse.swift
//  Auren
//
//  Created by Mattis Lefranc Adam on 30.07.2026.
//
import Foundation

struct TransactionResponse: Identifiable, Codable {
    let id: Int
    let transactionType: TransactionType
    let categoryId: Int
    let accountId: Int
    let amount: Double
    let createdAt: Date
    let comment: String
}
