import SwiftUI

struct AUButton: View {
    let title: String
    var isLoading: Bool = false
    var style: AUButtonStyle = .primary
    var width: CGFloat?
    var height: CGFloat = 54
    let action: () -> Void
    var fontSize: CGFloat = 15

    enum AUButtonStyle {
        case primary
        case ghost
    }

    var body: some View {
        if #available(iOS 26.0, *) {
            glassButton
        } else {
            legacyButton
        }
    }

    @available(iOS 26.0, *)
    private var glassButton: some View {
        Button(action: action) {
            label
        }
        .buttonStyle(
            style == .primary
                ? .glass(.regular.tint(Color.aurenGold))
                : .glass
        )
        .disabled(isLoading)
    }

    private var legacyButton: some View {
        Button(action: action) {
            label
                .background(style == .primary ? Color.aurenGold : .clear)
                .clipShape(RoundedRectangle(cornerRadius: AURadius.medium))
        }
        .buttonStyle(.plain)
        .disabled(isLoading)
        .opacity(isLoading ? 0.7 : 1)
    }

    @ViewBuilder
    private var label: some View {
        ZStack {
            if isLoading {
                ProgressView()
                    .tint(style == .primary ? Color.aurenBackground : Color.aurenGold)
            } else {
                Text(title)
                    .font(.custom("Inter", size: fontSize, relativeTo: .body))
                    .fontWeight(style == .primary ? .semibold : .regular)
                    .foregroundStyle(style == .primary ? Color.aurenBackground : Color.aurenGold)
            }
        }
        .frame(maxWidth: width == nil && style == .primary ? .infinity : nil)
        .frame(width: width)
        .frame(height: style == .primary ? height : nil)
        .contentShape(RoundedRectangle(cornerRadius: AURadius.medium))
    }
}

#Preview {
    AUButton(title: "Continue") {}
        .padding()
        .background(Color.aurenBackground)
}
