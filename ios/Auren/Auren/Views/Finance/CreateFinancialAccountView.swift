import SwiftUI

struct CreateFinancialAccountView: View {
    @StateObject private var viewModel = CreateFinancialAccountViewModel()

    @EnvironmentObject var session: SessionManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.aurenBackground
                .ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer(minLength: 40)

                VStack(spacing: 8) {
                    Text("New Bank Account")
                        .font(.custom("Fraunces", size: 34))
                        .foregroundColor(.aurenTextPrimary)
                        .bold()
                }

                VStack(spacing: 16) {
                    AUInput(
                        placeholder: "Account Name",
                        text: $viewModel.name,
                        icon: "banknote"
                    )
                    .textInputAutocapitalization(.never)
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.custom("Inter", size: 13))
                        .foregroundColor(.aurenNegative)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                }

                Spacer()

                AUButton(
                    title: viewModel.isLoading ? "Creating..." : "Create Account",
                    style: .ghost,
                    width: 200
                ) {
                    Task {
                        let success = await viewModel.createBankAccount(
                            session: session
                        )

                        if success {
                            dismiss()
                        }
                    }
                }
                .buttonStyle(.bordered)
                .disabled(viewModel.isLoading)
            }
            .padding()
        }
    }
}
