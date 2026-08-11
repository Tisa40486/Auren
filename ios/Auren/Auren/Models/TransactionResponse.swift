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
    let accountId: Int
    let amount: Int
    let createdAt: Date
    let comment: String
}
