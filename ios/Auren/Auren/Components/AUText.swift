//
//  AUText.swift
//  Auren
//

import SwiftUI

struct AUText: View {
    let text: String
    var style: AUTextStyle = .body

    enum AUTextStyle {
        case title      // Fraunces, headings
        case body        // Inter, primary text
        case caption      // Inter, secondary text
    }

    var body: some View {
        Text(text)
            .font(font)
            .foregroundColor(color)
    }

    private var font: Font {
        switch style {
        case .title: return .custom("Fraunces", size: 24)
        case .body: return .custom("Inter", size: 15)
        case .caption: return .custom("Inter", size: 13)
        }
    }

    private var color: Color {
        switch style {
        case .title, .body: return .aurenTextPrimary
        case .caption: return .aurenTextSecondary
        }
    }
}
