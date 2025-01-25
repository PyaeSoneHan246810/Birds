//
//  TabsView.swift
//  Birds
//
//  Created by Dylan on 24/01/2025.
//

import SwiftUI

struct TabsView: View {
    // MARK: - BODY
    var body: some View {
        TabView {
            Tab("Birds", systemImage: "bird.fill") {
                NavigationStack {
                    BirdsView()
                }
            }
            Tab("Favorites", systemImage: "heart.fill") {
                NavigationStack {
                    FavoritesView()
                }
            }
        }
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    TabsView()
}
