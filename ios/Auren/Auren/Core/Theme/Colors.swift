//
//  Colors.swift
//  Auren
//

import SwiftUI

extension Color {
    // MARK: - Auren palette

    static let aurenBackground = Color(hex: "0A0A0B")
    static let aurenSurface = Color(hex: "131315")
    static let aurenBorder = Color(hex: "232326")

    static let aurenTextPrimary = Color(hex: "EDEBE6")
    static let aurenTextSecondary = Color(hex: "8A867D")

    static let aurenGold = Color(hex: "C9A667")
    static let aurenBronze = Color(hex: "B8946A")

    static let aurenPositive = Color(hex: "6B9080")
    static let aurenNegative = Color(hex: "A8564F")
}
    
// MARK: - Hex helper

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}
