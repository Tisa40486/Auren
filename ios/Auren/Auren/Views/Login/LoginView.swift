//
//  LoginView.swift
//  Auren
//
//  Created by Mattis Lefranc Adam on 28.07.2026.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject var session: SessionManager
    @State private var navigateToCreateAccount = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Connexion")
                .font(.largeTitle)
                .bold()
            TextField("User Name", text: $viewModel.username)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)

            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.footnote)
            }

            Button {
                Task {
                    await viewModel.login(session: session)
                }
            } label: {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Text("Connect")
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.isLoading)

            Divider()

            Button("Create An Account") {
                navigateToCreateAccount = true
            }
            .font(.footnote)
        }
        .padding()
        .navigationDestination(isPresented: $navigateToCreateAccount) {
            CreateAccountView()
        }
    }
}
