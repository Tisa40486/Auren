import SwiftUI

struct CreateAccountView: View {
    @StateObject private var viewModel = CreateAccountViewModel()
    @EnvironmentObject var session: SessionManager

    var body: some View {
        VStack(spacing: 20) {
            Text("Créer un compte")
                .font(.largeTitle)
                .bold()

            TextField("Nom d'utilisateur", text: $viewModel.username)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)

            TextField("Email", text: $viewModel.email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)

            SecureField("Mot de passe", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.footnote)
            }

            Button {
                Task {
                    await viewModel.createAccount(session: session)
                }
            } label: {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Text("Créer mon compte")
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.isLoading)
        }
        .padding()
    }
}