import SwiftUI

struct AUCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        if #available(iOS 26.0, *) {
            content
                .padding(20)
                .glassEffect(in: .rect(cornerRadius: AURadius.large))
        } else {
            content
                .padding(20)
                .background(Color.aurenSurface)
                .overlay {
                    RoundedRectangle(cornerRadius: AURadius.large)
                        .stroke(Color.aurenBorder, lineWidth: 0.75)
                }
                .clipShape(RoundedRectangle(cornerRadius: AURadius.large))
        }
    }
}

#Preview {
    AUCard {
        VStack(alignment: .leading, spacing: 8) {
            Text("Total balance")
                .font(.headline)
            Text("€1,240.00")
                .font(.title)
        }
    }
    .padding()
    .background(Color.aurenBackground)
}
