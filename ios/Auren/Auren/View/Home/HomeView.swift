import SwiftUI

struct HomeView: View {
    @EnvironmentObject var session: SessionManager
    @StateObject private var viewModel = HomeViewModel()
    @State private var navigateToCreateFinancialAccount = false
    @State private var showLogoutConfirmation = false
    @State private var navigateToSettings = false

    var body: some View {
        ZStack {
            Color.aurenBackground.ignoresSafeArea()
            VStack(spacing: 20) {
                if viewModel.isLoading {
                    ProgressView()
                } else if let user = session.currentUser {
                    Text("Welcome, \(user.name) 👋")
                        .font(.title)
                    
                    if viewModel.hasAccount {
                        Text("Overview of the upcoming account here")
                        // TODO: AccountOverviewView
                    }
                }
            }
            .padding()
            .task {
                if let user = session.currentUser, let token = session.token {
                    await viewModel.checkAccount(userId: user.id, token: token)
                }
            }
            .navigationDestination(isPresented: $navigateToCreateFinancialAccount) {
                
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button() {
                    session.logout()
                } label: {
                    Label("Log Out", systemImage: "figure.walk.departure")
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Button {
                    navigateToSettings = true
                } label: {
                    Label("Go to settings", systemImage: "gearshape.fill")
                }
            }
        }
        .navigationDestination(isPresented: $navigateToSettings) {
            SettingsView()
        }
        }
    }

#Preview {
    NavigationStack {
        HomeView()
    }
    .environmentObject(SessionManager())
}
