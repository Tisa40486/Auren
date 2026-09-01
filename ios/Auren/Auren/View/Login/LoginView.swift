import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject private var l10n: LocalizationManager
    @State private var navigateToCreateAccount = false

    var body: some View {
        ZStack {
            Color.aurenBackground.ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer(minLength: 40)

                VStack(spacing: 8) {
                    Text("Auren")
                        .font(.custom("Fraunces", size: 34))
                        .foregroundColor(.aurenTextPrimary)

                    Text(l10n.tr(.appTagline))
                        .font(.custom("Inter", size: 14))
                        .foregroundColor(.aurenTextSecondary)
                        .italic()
                }

                VStack(spacing: 16) {
                    AUInput(placeholder: l10n.tr(.username), text: $viewModel.username, icon: "person")
                        .autocapitalization(.none)

                    AUInput(placeholder: l10n.tr(.password), text: $viewModel.password, isSecure: true, icon: "lock")

                    if let error = viewModel.errorMessage {
                        Text(error)
                            .font(.custom("Inter", size: 13))
                            .foregroundColor(.aurenNegative)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }

                AUButton(title: l10n.tr(.connect), isLoading: viewModel.isLoading) {
                    Task {
                        await viewModel.login(session: session)
                    }
                }

                HStack {
                    Rectangle().fill(Color.aurenBorder).frame(height: 1)
                    Text(l10n.tr(.orText))
                        .font(.custom("Inter", size: 12))
                        .foregroundColor(.aurenTextSecondary)
                    Rectangle().fill(Color.aurenBorder).frame(height: 1)
                }

                AUButton(title: l10n.tr(.createAnAccount), style: .ghost, width: 190) {
                    navigateToCreateAccount = true
                }

                Spacer()
            }
            .padding(.horizontal, 28)
        }
        .navigationDestination(isPresented: $navigateToCreateAccount) {
            CreateAccountView()
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
    .environmentObject(SessionManager())
    .environmentObject(LocalizationManager.shared)
}
