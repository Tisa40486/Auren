import SwiftUI

struct CreateAccountView: View {
    @StateObject private var viewModel = CreateAccountViewModel()
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject private var l10n: LocalizationManager
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.aurenBackground.ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer(minLength: 40)

                VStack(spacing: 8) {
                    Text(l10n.tr(.createAccountTitle))
                        .font(.custom("Fraunces", size: 34))
                        .foregroundColor(.aurenTextPrimary)
                        .bold()

                    Text(l10n.tr(.createAccountSubtitle))
                        .font(.custom("Fraunces", size: 16))
                        .foregroundColor(.accentColor)
                }

                VStack(spacing: 16) {
                    AUInput(placeholder: l10n.tr(.username), text: $viewModel.username, icon: "person")
                        .autocapitalization(.none)

                    AUInput(placeholder: l10n.tr(.email), text: $viewModel.email, icon: "envelope")
                        .autocapitalization(.none)

                    AUInput(placeholder: l10n.tr(.password), text: $viewModel.password, isSecure: true, icon: "lock")

                    AUInput(placeholder: l10n.tr(.confirmPassword), text: $viewModel.confirm_password, isSecure: true, icon: "lock")
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.custom("Inter", size: 13))
                        .foregroundColor(.aurenNegative)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                AUButton(title: l10n.tr(.createAccountButton), isLoading: viewModel.isLoading, width: 180) {
                    Task {
                        await viewModel.createAccount(session: session)
                        if viewModel.errorMessage == nil {
                            dismiss()
                        }
                    }
                }
                .disabled(viewModel.isLoading)

                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    CreateAccountView()
        .environmentObject(SessionManager())
        .environmentObject(LocalizationManager.shared)
}
