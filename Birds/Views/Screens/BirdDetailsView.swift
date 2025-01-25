//
//  BirdDetailsView.swift
//  Birds
//
//  Created by Dylan on 24/01/2025.
//

import SwiftUI
import RealmSwift

struct BirdDetailsView: View {
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - REALM POPERTIeS
    @ObservedResults(BirdObject.self) private var birdObjects
    
    // MARK: - PROPERTIES
    let birdDetails: BirdDetailsUIModel
    
    // MARK: - INITIALIZER
    init(birdDetails: BirdDetailsUIModel) {
        self.birdDetails = birdDetails
        UIScrollView.appearance().bounces = false
    }
    
    // MARK: - COMPUTED PROPERTIES
    private var isFavorite: Bool {
        birdObjects.first(where: { $0.birdId == birdDetails.id}) != nil
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            GradientBackgroundView()
            detailsScrollView()
        }
        .ignoresSafeArea()
        .navigationTitle(birdDetails.englishName)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbarVisibility(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                backButtonView()
            }
            ToolbarItem(placement: .topBarTrailing) {
                toggleFavoriteButtonView()
            }
        }
    }
    
    // MARK: - VIEW BUILDERS
    @ViewBuilder
    private func detailsScrollView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading) {
                if let birdImageView = Image(birdDetails.imageFileName) {
                    birdImageView
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, minHeight: 400.0, maxHeight: 400.0)
                        .clipped()
                }
                VStack(alignment: .leading, spacing: 20.0) {
                    Text("\(birdDetails.myanmarName) (\(birdDetails.englishName))")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                        .lineSpacing(8.0)
                    Text(birdDetails.description)
                        .font(.body)
                        .lineSpacing(12.0)
                }
                .padding(.horizontal, 16.0)
                .padding(.vertical, 12.0)
            }
            .padding(.bottom, 40.0)
        }
    }
    @ViewBuilder
    private func backButtonView() -> some View {
        Button("Back", systemImage: "chevron.left") {
            dismiss()
        }
    }
    @ViewBuilder
    private func toggleFavoriteButtonView() -> some View {
        Button("Favorite", systemImage: isFavorite ? "heart.fill" : "heart") {
            isFavorite ? removeBirdFromFavorites() : saveBirdToFavorites() 
        }
    }
    
    // MARK: - FUNCTIONS
    private func saveBirdToFavorites() {
        let birdObject = BirdObject()
        birdObject.birdId = birdDetails.id
        birdObject.myanmarName = birdDetails.myanmarName
        birdObject.englishName = birdDetails.englishName
        birdObject.desc = birdDetails.description
        birdObject.imageFileName = birdDetails.imageFileName
        $birdObjects.append(birdObject)
    }
    private func removeBirdFromFavorites() {
        guard let birdObject = birdObjects.first(where: { $0.birdId == birdDetails.id}) else {
            return
        }
        $birdObjects.remove(birdObject)
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    NavigationStack {
        BirdDetailsView(birdDetails: BirdDetailsUIModel.preview)
    }
}
