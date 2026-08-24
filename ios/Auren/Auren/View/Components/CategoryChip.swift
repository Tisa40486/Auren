//
//  CategoryChip.swift
//  Auren
//
//  Created by Mattis Lefranc Adam on 19.08.2026.
//


import SwiftUI

struct CategoryChip: View {
    let name: String
    let icon: String
    let colorHex: String

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.caption)
            Text(name)
                .font(.caption)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(Color(hex: colorHex).opacity(0.15))
        .foregroundColor(Color(hex: colorHex))
        .clipShape(Capsule())
    }
}

#Preview {
    CategoryChip(
        name: "Groceries",
        icon: "cart.fill",
        colorHex: "4CAF50"
    )
    .padding()
}
