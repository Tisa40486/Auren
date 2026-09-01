import SwiftUI

// MARK: - Button Styles (HIG Compliant)

struct AUPrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    var minHeight: CGFloat = 44
    var cornerRadius: CGFloat = AURadius.medium

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("Inter", size: 15, relativeTo: .body))
            .fontWeight(.semibold)
            .foregroundStyle(Color.aurenBackground)
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .frame(minHeight: minHeight)
            .background(Color.aurenGold)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .opacity(configuration.isPressed ? 0.8 : (isEnabled ? 1.0 : 0.5))
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}

struct AUGhostButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    var minHeight: CGFloat = 44
    var cornerRadius: CGFloat = AURadius.medium

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("Inter", size: 15, relativeTo: .body))
            .fontWeight(.medium)
            .foregroundStyle(Color.aurenGold)
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .frame(minHeight: minHeight)
            .background(Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .opacity(configuration.isPressed ? 0.6 : (isEnabled ? 1.0 : 0.5))
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}

// MARK: - AUButton Component

struct AUButton: View {
    let title: String
    var isLoading: Bool = false
    var style: AUButtonStyle = .primary
    var width: CGFloat? = nil
    var height: CGFloat = 44
    var fontSize: CGFloat = 15
    let action: () -> Void

    enum AUButtonStyle {
        case primary
        case ghost
    }

    var body: some View {
        Button(action: action) {
            ZStack {
                if isLoading {
                    ProgressView()
                        .tint(style == .primary ? Color.aurenBackground : Color.aurenGold)
                } else {
                    Text(title)
                        .font(.custom("Inter", size: fontSize, relativeTo: .body))
                }
            }
            .frame(maxWidth: width != nil ? width : (style == .primary ? .infinity : nil))
            .frame(width: width)
        }
        .applyAUStyle(style, minHeight: height)
        .disabled(isLoading)
        .accessibilityLabel(title)
        .accessibilityValue(isLoading ? "Loading" : "")
        .accessibilityAddTraits(.isButton)
    }
}

private extension View {
    @ViewBuilder
    func applyAUStyle(_ style: AUButton.AUButtonStyle, minHeight: CGFloat) -> some View {
        switch style {
        case .primary:
            self.buttonStyle(AUPrimaryButtonStyle(minHeight: minHeight))
        case .ghost:
            self.buttonStyle(AUGhostButtonStyle(minHeight: minHeight))
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        AUButton(title: "Primary Button") {}
        AUButton(title: "Loading Button", isLoading: true) {}
        AUButton(title: "Ghost Button", style: .ghost) {}
    }
    .padding()
    .background(Color.aurenBackground)
}
