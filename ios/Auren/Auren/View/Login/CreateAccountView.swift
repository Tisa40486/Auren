import SwiftUI

struct CreateAccountView: View {
    @StateObject private var viewModel = CreateAccountViewModel()
    @EnvironmentObject var session: SessionManager
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.aurenBackground.ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer(minLength: 40)

                VStack(spacing: 8) {
                    Text("Create Account")
                        .font(.custom("Fraunces", size: 34))
                        .foregroundColor(.aurenTextPrimary)
                        .bold()

                    Text("Create your account to continue")
                        .font(.custom("Fraunces", size: 16))
                        .foregroundColor(.accentColor)
                }

                VStack(spacing: 16) {
                    AUInput(placeholder: "Username", text: $viewModel.username, icon: "person")
                        .autocapitalization(.none)

                    AUInput(placeholder: "Email", text: $viewModel.email, icon: "envelope")
                        .autocapitalization(.none)

                    AUInput(placeholder: "Password", text: $viewModel.password, isSecure: true, icon: "lock")

                    AUInput(placeholder: "Confirm Password", text: $viewModel.confirm_password, isSecure: true, icon: "lock")
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.custom("Inter", size: 13))
                        .foregroundColor(.aurenNegative)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                AUButton(title: "Create Account", isLoading: viewModel.isLoading, width: 150) {
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
}
