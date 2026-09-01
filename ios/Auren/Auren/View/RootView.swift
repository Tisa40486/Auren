import SwiftUI

struct RootView: View {
    @EnvironmentObject private var session: SessionManager
    @EnvironmentObject private var l10n: LocalizationManager

    var body: some View {
        if session.isAuthenticated {
            TabView {
                NavigationStack {
                    HomeView()
                }
                .tabItem {
                    Label(l10n.tr(.home), systemImage: "house.fill")
                }

                NavigationStack {
                    AccountListView()
                }
                .tabItem {
                    Label(l10n.tr(.accounts), systemImage: "building.columns.fill")
                }
            }
        } else {
            NavigationStack {
                LoginView()
            }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(SessionManager())
        .environmentObject(LocalizationManager.shared)
}
