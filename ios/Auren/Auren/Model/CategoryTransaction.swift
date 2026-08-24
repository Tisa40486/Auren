//
//  CategoryType.swift
//  Auren
//
//  Created by Mattis Lefranc Adam on 19.08.2026.
//

import Foundation


struct CategoryTransaction: Codable, Identifiable {
    let id: Int
    let name: String
    let type: CategoryType
    let color: String
    let icon: String
}
