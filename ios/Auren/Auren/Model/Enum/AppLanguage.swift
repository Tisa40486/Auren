import Foundation
import SwiftUI

enum AppLanguage: String, CaseIterable, Identifiable {
    case system = "system"
    case french = "fr"
    case english = "en"
    case spanish = "es"
    case german = "de"
    case italian = "it"

    var id: String { rawValue }

    var title: String {
        switch self {
        case .system:
            return "Système (par défaut)"
        case .french:
            return "Français"
        case .english:
            return "English"
        case .spanish:
            return "Español"
        case .german:
            return "Deutsch"
        case .italian:
            return "Italiano"
        }
    }

    var flag: String {
        switch self {
        case .system:
            return "🌐"
        case .french:
            return "🇫🇷"
        case .english:
            return "🇬🇧"
        case .spanish:
            return "🇪🇸"
        case .german:
            return "🇩🇪"
        case .italian:
            return "🇮🇹"
        }
    }

    var locale: Locale {
        switch self {
        case .system:
            return Locale.autoupdatingCurrent
        case .french:
            return Locale(identifier: "fr_FR")
        case .english:
            return Locale(identifier: "en_US")
        case .spanish:
            return Locale(identifier: "es_ES")
        case .german:
            return Locale(identifier: "de_DE")
        case .italian:
            return Locale(identifier: "it_IT")
        }
    }
}
