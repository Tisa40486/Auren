//
//  AUCard.swift
//  Auren
//

import SwiftUI

struct AUCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(16)
            .background(Color.aurenSurface)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.aurenBorder, lineWidth: 0.75)
            )
            .cornerRadius(4)
    }
}
