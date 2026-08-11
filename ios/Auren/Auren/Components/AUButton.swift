//
//  AUButton.swift
//  Auren
//

import SwiftUI

struct AUButton: View {
    let title: String
    var isLoading: Bool = false
    var style: AUButtonStyle = .primary
    var width: CGFloat? = nil
    var height: CGFloat = 54
    let action: () -> Void

    enum AUButtonStyle { case primary, ghost }

    var body: some View {
        Button(action: action) {
            ZStack {
                if isLoading {
                    ProgressView()
                        .tint(style == .primary ? Color.aurenBackground : Color.aurenGold)
                } else {
                    Text(title)
                        .font(.custom("Inter", size: 15))
                        .fontWeight(style == .primary ? .semibold : .regular)
                        .foregroundColor(style == .primary ? Color.aurenBackground : Color.aurenGold)
                }
            }
            .frame(maxWidth: width == nil && style == .primary ? .infinity : nil)
            .frame(width: width ?? 100)
            .frame(height: style == .primary ? height : nil)            .frame(height: style == .primary ? height : nil)
            .background(style == .primary ? Color.aurenGold : Color.clear)
            .cornerRadius(AURadius.medium)
        }
        .disabled(isLoading)
        .opacity(isLoading ? 0.7 : 1)
    }
}
