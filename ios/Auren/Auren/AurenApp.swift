import SwiftUI

@main
struct AurenApp: App {
    @StateObject private var session = SessionManager()
    @AppStorage("appTheme") private var selectedTheme = AppTheme.dark.rawValue

    private var preferredColorScheme: ColorScheme? {
        AppTheme(rawValue: selectedTheme)?.colorScheme ?? .dark
    }

    var body: some Scene {
        WindowGroup {
            RootView() // plus de NavigationStack ici
                .environmentObject(session)
                .preferredColorScheme(preferredColorScheme)
        }
    }
}
