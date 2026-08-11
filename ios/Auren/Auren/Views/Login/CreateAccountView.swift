import SwiftUI

struct CreateAccountView: View {
    @StateObject private var viewModel = CreateAccountViewModel()
    @EnvironmentObject var session: SessionManager
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.largeTitle)
                .bold()

            TextField("User Name", text: $viewModel.username)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)

            TextField("Email", text: $viewModel.email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)

            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
            SecureField("Confirm Password", text: $viewModel.confirm_password)
                .textFieldStyle(.roundedBorder)

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.footnote)
            }

            Button {
                Task {
                    await viewModel.createAccount(session: session)
                    if viewModel.errorMessage == nil {
                        dismiss()
                    }
                }
            } label: {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Text("Create Account")
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.isLoading)
        }
        .padding()
    }
}
