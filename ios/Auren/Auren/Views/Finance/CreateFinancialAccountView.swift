//
//  CreateFinancialAccountView.swift
//  Auren
//
//  Created by Mattis Lefranc Adam on 30.07.2026.
//
import SwiftUI

struct CreateFinancialAccountView: View {
    @StateObject private var viewModel = CreateFinancialAccountViewModel()
    @EnvironmentObject var session: SessionManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.aurenBackground.ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer(minLength: 40)

                VStack(spacing: 8) {
                    Text("New Bank Account")
                        .font(.custom("Fraunces", size: 34))
                        .foregroundColor(.aurenTextPrimary)
                        .bold()
                }

                VStack(spacing: 16) {
                    AUInput(placeholder: "Account Name", text: $viewModel.name, icon: "banknote")
                        .textInputAutocapitalization(.never)

                    AUInput(placeholder: "Code PIN", text: $viewModel.pinCode, isPin: true, icon: "lock.fill")
                        .textInputAutocapitalization(.never)

                    AUInput(placeholder: "Code PIN confirmation", text: $viewModel.confirm_pinCode, isPin: true, icon: "lock")
                        .textInputAutocapitalization(.never)
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.custom("Inter", size: 13))
                        .foregroundColor(.aurenNegative)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                Spacer()

                
                AUButton(title: "Create Account", style: .ghost, width: 200) {
                    Task{
                        await viewModel.createBankAccount(session: session, )
                    }
                }.buttonStyle(.bordered)
            }
            .padding()
        }
    }
}
