import SwiftUI

struct RootView: View {
    @EnvironmentObject var session: SessionManager

    var body: some View {
        Group {
            if session.isAuthenticated {
                NavigationStack {
                    TabView {
                        HomeView()
                            .tabItem {
                                Label("Home", systemImage: "house.fill")
                            }
                        AccountListView()
                            .tabItem {
                                Label("Accounts", systemImage: "building.columns.fill")
                            }
                    }
                }
            } else {
                NavigationStack {
                    LoginView()
                }
            }
        }
    }
}
