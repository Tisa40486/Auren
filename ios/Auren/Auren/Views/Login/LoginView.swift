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
        ZStack {
            Color.aurenBackground.ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer(minLength: 40)

                
                VStack(spacing: 8) {
                    Text("Auren")
                        .font(.custom("Fraunces", size: 34))
                        .foregroundColor(.aurenTextPrimary)

                    Text("One app to manage your life.")
                        .font(.custom("Inter", size: 14))
                        .foregroundColor(.aurenTextSecondary)
                        .italic()
                }

                
                VStack(spacing: 16) {
                    AUInput(placeholder: "Username", text: $viewModel.username, icon: "person")
                        .autocapitalization(.none)
                    
                    AUInput(placeholder: "Password", text: $viewModel.password, isSecure: true, icon: "lock")
                    
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .font(.custom("Inter", size: 13))
                            .foregroundColor(.aurenNegative)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }

                AUButton(title: "Connect", isLoading: viewModel.isLoading) {
                    Task {
                        await viewModel.login(session: session)
                    }
                }

                
                HStack {
                    Rectangle().fill(Color.aurenBorder).frame(height: 1)
                    Text("or")
                        .font(.custom("Inter", size: 12))
                        .foregroundColor(.aurenTextSecondary)
                    Rectangle().fill(Color.aurenBorder).frame(height: 1)
                }

                AUButton(title: "Create an account", style: .ghost, width: 200) {
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
