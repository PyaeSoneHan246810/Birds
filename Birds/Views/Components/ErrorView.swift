//
//  ErrorView.swift
//  Birds
//
//  Created by Dylan on 24/01/2025.
//

import SwiftUI

struct ErrorView: View {
    // MARK: - PROPERTIES
    let error: LocalizedError
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 16.0) {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .symbolEffect(.breathe)
                .frame(width: 48.0, height: 48.0)
                .foregroundStyle(.accent)
            Text(error.localizedDescription)
                .font(.subheadline)
        }
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    ErrorView(
        error: FileDecodingError.fileNotFound
    )
}
