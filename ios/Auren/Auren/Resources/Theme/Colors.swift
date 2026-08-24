import SwiftUI
import UIKit

enum AppTheme: String, CaseIterable, Identifiable {
    case dark
    case light
    case system

    var id: String { rawValue }

    var title: String {
        switch self {
        case .dark:
            "Dark"
        case .light:
            "Light"
        case .system:
            "System"
        }
    }

    var colorScheme: ColorScheme? {
        switch self {
        case .dark:
            .dark
        case .light:
            .light
        case .system:
            nil
        }
    }
}

extension Color {
    // MARK: - Auren palette

    static let aurenBackground = adaptive(dark: "0A0A0B", light: "F7F5F0")
    static let aurenSurface = adaptive(dark: "131315", light: "FFFDF8")
    static let aurenBorder = adaptive(dark: "6C6971", light: "87837A")

    static let aurenTextPrimary = adaptive(dark: "F5F2EB", light: "1C1B1A")
    static let aurenTextSecondary = adaptive(dark: "B8B3A8", light: "5E5A52")

    static let aurenGold = adaptive(dark: "D8B56F", light: "765616")
    static let aurenBronze = adaptive(dark: "D2A97E", light: "6D4B2C")

    static let aurenPositive = adaptive(dark: "8FC6AC", light: "2F6F55")
    static let aurenNegative = adaptive(dark: "EE9089", light: "963F39")

    private static func adaptive(dark: String, light: String) -> Color {
        Color(uiColor: UIColor { traits in
            UIColor(hex: traits.userInterfaceStyle == .dark ? dark : light)
        })
    }
}

// MARK: - Hex helpers

extension Color {
    init(hex: String) {
        self.init(uiColor: UIColor(hex: hex))
    }
}

private extension UIColor {
    convenience init(hex: String) {
        let sanitizedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
        let value = UInt64(sanitizedHex, radix: 16) ?? 0

        self.init(
            red: CGFloat((value >> 16) & 0xFF) / 255,
            green: CGFloat((value >> 8) & 0xFF) / 255,
            blue: CGFloat(value & 0xFF) / 255,
            alpha: 1
        )
    }
}
