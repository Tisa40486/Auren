import SwiftUI

@main
struct AurenApp: App {
    @StateObject private var session = SessionManager()
    @StateObject private var localization = LocalizationManager.shared
    @AppStorage("appTheme") private var selectedTheme = AppTheme.dark.rawValue
    @AppStorage("appLanguage") private var selectedLanguage = AppLanguage.system.rawValue

    private var preferredColorScheme: ColorScheme? {
        AppTheme(rawValue: selectedTheme)?.colorScheme ?? .dark
    }

    private var preferredLocale: Locale {
        AppLanguage(rawValue: selectedLanguage)?.locale ?? Locale.autoupdatingCurrent
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(session)
                .environmentObject(localization)
                .preferredColorScheme(preferredColorScheme)
                .environment(\.locale, preferredLocale)
        }
    }
}
