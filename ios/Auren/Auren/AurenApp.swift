import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct AurenApp: App {
    @StateObject private var session = SessionManager()
    @StateObject private var localization = LocalizationManager.shared
    @AppStorage("appTheme") private var selectedTheme = AppTheme.dark.rawValue
    @AppStorage("appLanguage") private var selectedLanguage = AppLanguage.system.rawValue
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    private var preferredColorScheme: ColorScheme? {
        AppTheme(rawValue: selectedTheme)?.colorScheme ?? .dark
    }

    private var preferredLocale: Locale {
        AppLanguage(rawValue: selectedLanguage)?.locale ?? Locale.autoupdatingCurrent
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(session)
                .environmentObject(localization)
                .preferredColorScheme(preferredColorScheme)
                .environment(\.locale, preferredLocale)
        }
    }
}
