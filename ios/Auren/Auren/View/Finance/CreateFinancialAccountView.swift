import SwiftUI

struct CreateFinancialAccountView: View {
    @StateObject private var viewModel = CreateFinancialAccountViewModel()
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject private var l10n: LocalizationManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.aurenBackground
                .ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer(minLength: 40)

                VStack(spacing: 8) {
                    Text(l10n.tr(.newBankAccount))
                        .font(.custom("Fraunces", size: 34))
                        .foregroundColor(.aurenTextPrimary)
                        .bold()
                }

                VStack(spacing: 16) {
                    AUInput(
                        placeholder: l10n.tr(.accountName),
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
                    title: viewModel.isLoading ? l10n.tr(.creating) : l10n.tr(.createAccountButton),
                    style: .ghost,
                    width: 180
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
                .disabled(viewModel.isLoading)
            }
            .padding()
        }
    }
}

#Preview {
    CreateFinancialAccountView()
        .environmentObject(SessionManager())
        .environmentObject(LocalizationManager.shared)
}
