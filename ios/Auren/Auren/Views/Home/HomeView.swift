import SwiftUI

struct HomeView: View {
    @EnvironmentObject var session: SessionManager
    @StateObject private var viewModel = HomeViewModel()
    @State private var navigateToCreateFinancialAccount = false

    var body: some View {
        VStack(spacing: 20) {
            if viewModel.isLoading {
                ProgressView()
            } else if let user = session.currentUser {
                Text("Welcome, \(user.name) 👋")
                    .font(.title)

                if viewModel.hasAccount {
                    Text("Overview of the upcoming account here")
                    // TODO: AccountOverviewView
                } else {
                    Button("Logout") {
                        session.logout()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .padding()
    }
}
