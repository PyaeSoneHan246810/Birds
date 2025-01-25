//
//  FavoritesView.swift
//  Birds
//
//  Created by Dylan on 24/01/2025.
//

import SwiftUI
import RealmSwift

struct FavoritesView: View {
    // MARK: - REALM PROPERTIES
    @ObservedResults(BirdObject.self) private var birdObjects
    
    // MARK: - PROPERTY WRAPPERS
    @Namespace private var birdZoomTransitionNamespace
    
    // MARK: - BODY
    var body: some View {
        Group {
            if birdObjects.isEmpty {
                EmptyContentView(
                    title: "No Favorites",
                    systemImage: "bird.fill",
                    desctiption: "Your favorite birds will appear here."
                )
            } else {
                favoriteBirdsListView()
            }
        }
        .navigationTitle("Favorites")
        .navigationDestination(for: BirdObject.self) { birdObject in
            let birdDetails = BirdDetailsUIModel(birdObject: birdObject)
            BirdDetailsView(birdDetails: birdDetails)
                .navigationTransition(
                    .zoom(sourceID: birdObject.birdId, in: birdZoomTransitionNamespace)
                )
        }
    }
    
    // MARK: - VIEW BUILDERS
    @ViewBuilder
    private func favoriteBirdsListView() -> some View {
        List {
            ForEach(birdObjects, id: \.birdId) { birdObject in
                NavigationLink(value: birdObject) {
                    favoriteBirdItemView(birdObject)
                }
            }
            .onDelete(perform: $birdObjects.remove(atOffsets:))
            .listRowInsets(.init(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 8.0))
            .listRowBackground(Color.clear)
        }
        .listRowSpacing(12.0)
    }
    @ViewBuilder
    private func favoriteBirdItemView(_ birdObject: BirdObject) -> some View {
        HStack(spacing: 16.0) {
            if let birdImageView = Image(birdObject.imageFileName) {
                birdImageView
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120.0, height: 100.0)
                    .clipShape(.rect(cornerRadius: 12.0))
                    .matchedTransitionSource(id: birdObject.birdId, in: birdZoomTransitionNamespace)
            }
            VStack(alignment: .leading, spacing: 4.0) {
                Text(birdObject.myanmarName)
                    .font(.headline)
                Text(birdObject.englishName)
                    .font(.subheadline)
            }
        }
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    NavigationStack {
        FavoritesView()
    }
}
