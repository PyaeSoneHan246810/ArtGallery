//
//  ArtsView.swift
//  ArtGallery
//
//  Created by Dylan on 26/01/2025.
//

import SwiftUI
import StaggeredList

struct ArtsView: View {
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(ArtGalleryModel.self) private var artGalleryModel
    
    // MARK: - STATE PROPERTIES
    @State private var selectedGallery: Gallery?
    
    // MARK: - COMPUTED PROPERTIES
    private var galleries: [Gallery] {
        artGalleryModel.galleries.reversed().sorted {
            let firstArtDesc = getArt(for: $0)?.artDescription
            let secondArtDesc = getArt(for: $1)?.artDescription
            return firstArtDesc != nil && secondArtDesc == nil
        }
    }
    
    // MARK: - BODY
    var body: some View {
        StaggeredLayoutList(
            data: galleries,
            numberOfColumns: 2,
            horizontalSpacing: 8.0,
            verticalSpacing: 8.0
        ) { gallery in
            galleryArtView(getArt(for: gallery))
                .onTapGesture {
                    selectedGallery = gallery
                }
        }
        .navigationTitle("Arts")
        .fullScreenCover(item: $selectedGallery) { gallery in
            NavigationStack {
                ArtDetailsView(
                    artId: gallery.artId,
                    artistId: gallery.artistId
                )
            }
        }
    }
    
    // MARK: - VIEWBUILDERS
    @ViewBuilder
    private func galleryArtView(_ art: Art?) -> some View {
        if let art {
            Image("\(art.artId)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(.rect(cornerRadius: 8.0))
        }
        
    }
    
    // MARK: - FUNCTIONS
    private func getArt(for gallery: Gallery) -> Art? {
        let art = artGalleryModel.arts.first(where: { $0.artId == gallery.artId})
        return art
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    let artGalleryModel = ArtGalleryModel(
        galleries: Gallery.previewList,
        arts: Art.previewList,
        artists: Artist.previewList
    )
    NavigationStack {
        ArtsView()
    }
    .environment(artGalleryModel)
}
