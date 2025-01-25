//
//  EmptyContentView.swift
//  Birds
//
//  Created by Dylan on 25/01/2025.
//

import SwiftUI

struct EmptyContentView: View {
    // MARK: - PROPERTIES
    var title: String = "Empty Content"
    var systemImage: String = "tray.fill"
    var desctiption: String = "There is no content here."
    
    // MARK: - BODY
    var body: some View {
        ContentUnavailableView(
            title,
            systemImage: systemImage,
            description: Text(desctiption)
        )
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    EmptyContentView()
}
