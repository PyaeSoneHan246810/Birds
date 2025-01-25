//
//  BirdsView.swift
//  Birds
//
//  Created by Dylan on 24/01/2025.
//

import SwiftUI

struct BirdsView: View {
    // MARK: - STATE PROPERTIES
    @State private var birds: [Bird] = []
    @State private var error: LocalizedError?
    @State private var searchText: String = ""
    @State private var isSearchTextFieldVisible: Bool = false
    
    // MARK: - PROPERTY WRAPPERS
    @Namespace private var birdZoomTransitionNamespace
    
    // MARK: - PROPERTIES
    private let gridColumns: [GridItem] = [
        GridItem(.adaptive(minimum: 160), spacing: 16.0)
    ]
    
    // MARK: - COMPUTED PROPERTIES
    private var trimmedSearchText: String {
        searchText.trimmed()
    }
    private var filteredBirds: [Bird] {
        if trimmedSearchText.isEmpty {
            return birds
        } else {
            return birds.filter { bird in
                bird.myanmarName.lowercased().contains(trimmedSearchText.lowercased()) || bird.englishName.lowercased().contains(trimmedSearchText.lowercased())
            }
        }
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            GradientBackgroundView()
            if let error {
                ErrorView(
                    error: error
                )
            } else {
                birdsScrollView()
            }
        }
        .overlay {
            if isSearchTextFieldVisible {
                searchOverlayView()
            }
        }
        .navigationTitle("Birds")
        .navigationBarTitleDisplayMode(.large)
        .navigationDestination(for: Bird.self) { bird in
            let birdDetails = BirdDetailsUIModel(bird: bird)
            BirdDetailsView(birdDetails: birdDetails)
                .navigationTransition(
                    .zoom(sourceID: bird.id, in: birdZoomTransitionNamespace)
                )
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                searchButtonView()
            }
        }
        .onAppear {
            loadBirds()
        }
    }
    
    // MARK: - VIEW BUILDERS
    @ViewBuilder
    private func birdsScrollView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(
                columns: gridColumns,
                spacing: 16.0
            ) {
                ForEach(filteredBirds) { bird in
                    NavigationLink(value: bird) {
                        birdItemView(bird)
                    }
                }
                .scrollTransition(.animated(.smooth), axis: .vertical) { content, phase in
                    content
                        .opacity(phase.isIdentity ? 1 : 0.5)
                        .scaleEffect(phase.isIdentity ? 1 : 0.75)
                }
            }
            .padding(.horizontal, 16.0)
            .padding(.vertical, 12.0)
        }
    }
    @ViewBuilder
    private func birdItemView(_ bird: Bird) -> some View {
        Rectangle()
            .fill(Color(uiColor: .systemGray6))
            .overlay {
                if let birdImageView = Image(bird.imageFileName) {
                    birdImageView
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 28.0, height: 28.0)
                        .foregroundStyle(.accent)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 160.0)
            .clipShape(.rect(cornerRadius: 16.0))
            .matchedTransitionSource(id: bird.id, in: birdZoomTransitionNamespace)
    }
    @ViewBuilder
    private func searchButtonView() -> some View {
        Button("Search", systemImage: "magnifyingglass") {
            withAnimation(.spring(duration: 0.25)) {
                isSearchTextFieldVisible.toggle()
            }
        }
    }
    @ViewBuilder
    private func searchOverlayView() -> some View {
        ZStack(alignment: .center) {
            Rectangle()
                .fill(.black)
                .opacity(0.75)
                .blur(radius: 4.0)
                .ignoresSafeArea()
            searchTextFieldView()
                .padding(.horizontal, 16.0)
                .padding(.vertical, 12.0)
        }
        .transition(.opacity)
    }
    @ViewBuilder
    private func searchTextFieldView() -> some View {
        TextField("Search", text: $searchText)
            .textInputAutocapitalization(.never)
            .padding(.horizontal, 12.0)
            .padding(.vertical, 16.0)
            .background(Color(uiColor: .systemGray5))
            .overlay(alignment: .trailing) {
                searchCancelButtonView()
            }
            .clipShape(.rect(cornerRadius: 16.0))
            .onSubmit {
                isSearchTextFieldVisible.toggle()
            }
    }
    @ViewBuilder
    private func searchCancelButtonView() -> some View {
        Button {
            searchText = ""
            isSearchTextFieldVisible.toggle()
        } label: {
            Image(systemName: "x.circle.fill")
                .imageScale(.medium)
        }
        .tint(.secondary)
        .padding(.trailing, 12.0)
    }
    
    // MARK: - FUNCTIONS
    private func loadBirds() {
        error = nil
        do {
            let birdsDto: BirdsDto = try Bundle.main.decode("Birds")
            birds = birdsDto.birds
        } catch {
            if let error = error as? LocalizedError {
                self.error = error
            }
        }
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    NavigationStack {
        BirdsView()
    }
}
