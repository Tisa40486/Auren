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
        Form {
            Section(header: Text("Account Informations")) {
                TextField("Account name", text: $viewModel.name)
                    .autocorrectionDisabled()
            }

            Section(header: Text("Code PIN")) {
                SecureField("Code PIN", text: $viewModel.pinCode)
                    .keyboardType(.numberPad)

                SecureField("Confirm Code PIN", text: $viewModel.confirm_pinCode)
                    .keyboardType(.numberPad)
            }

            if let error = viewModel.errorMessage {
                Section {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
            }

            Section {
                Button {
                    Task {
                            await viewModel.createBankAccount(session: session)
                            if viewModel.errorMessage == nil {
                                dismiss()
                            }
                        }
                    }
                label: {
                    if viewModel.isLoading {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    } else {
                        Text("Create Account")
                            .frame(maxWidth: .infinity)
                    }
                }
                .disabled(viewModel.isLoading)
            }
        }
        .navigationTitle("new Account")
    }
}
