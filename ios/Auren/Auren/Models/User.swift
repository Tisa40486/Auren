//
//  User.swift
//  Auren
//
//  Created by Mattis Lefranc Adam on 28.07.2026.
//
struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
    let password: String
    let updated: Bool
}
