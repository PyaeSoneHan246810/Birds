//
//  GradientBackgroundView.swift
//  Birds
//
//  Created by Dylan on 25/01/2025.
//

import SwiftUI

struct GradientBackgroundView: View {
    // MARK: - BODY
    var body: some View {
        LinearGradient(
            colors: [.accent.opacity(0.25), Color(uiColor: .systemBackground), .accent.opacity(0.25)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ).ignoresSafeArea()
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    GradientBackgroundView()
}
