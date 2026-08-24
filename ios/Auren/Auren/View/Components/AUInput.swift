//
//  AUInput.swift
//  Auren
//

import SwiftUI

struct AUInput: View {
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var isPin: Bool = false

    var icon: String? = nil

    var body: some View {
        HStack(spacing: 10) {
            if let icon {
                Image(systemName: icon)
                    .foregroundColor(.aurenTextSecondary)
                    .frame(width: 18)
            }

            Group {
                if isSecure {
                    SecureField("", text: $text, prompt: placeholderText)
                } else {
                    TextField("", text: $text, prompt: placeholderText)
                }
            }
            .font(.custom("Inter", size: 15))
            .foregroundColor(.aurenTextPrimary)
        }
        .padding(.horizontal, 16)
        .frame(height: 52)
        .background(Color.aurenSurface)
        .overlay(
            RoundedRectangle(cornerRadius: AURadius.medium)
                .stroke(Color.aurenBorder, lineWidth: 0.75)
        )
        .cornerRadius(AURadius.medium)
        .keyboardType(isPin ? .numberPad : .default)
    }

    private var placeholderText: Text {
        Text(placeholder).foregroundColor(.aurenTextSecondary)
    }
    

}

#Preview {
    @Previewable @State var text = ""

    AUInput(
        placeholder: "Email",
        text: $text,
        icon: "envelope"
    )
    .padding()
    .background(Color.aurenBackground)
}
