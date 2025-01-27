//
//  ArtistDetailsView.swift
//  ArtGallery
//
//  Created by Dylan on 27/01/2025.
//

import SwiftUI

struct ArtistDetailsView: View {
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.dismiss) private var dismiss
    @Environment(ArtGalleryModel.self) private var artGalleryModel
    
    // MARK: - STATE PROPERTIES
    @State private var selectedGallery: Gallery?
    
    // MARK: - PROPERTIES
    let artist: Artist
    
    // MARK: - COMPUTED PROPERTIES
    private var galleries: [Gallery] {
        artGalleryModel.galleries.filter { $0.artistId == artist.artistId}
    }
    private var facebookLink: String {
        artist.social[0].link
    }
    private var instagramLink: String {
        artist.social[1].link
    }
     
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 24.0) {
                artistImageView()
                artistSocialsView()
                    .padding(.horizontal, 16.0)
                artistGalleryView()
            }
        }
        .navigationTitle(artist.artistName)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Back", systemImage: "chevron.left") {
                    dismiss()
                }
            }
        }
        .fullScreenCover(item: $selectedGallery) { gallery in
            ArtDetailsView(
                artId: gallery.artId,
                artistId: gallery.artistId
            )
        }
    }
    
    // MARK: - VIEW BUILDERS
    @ViewBuilder
    private func artistImageView() -> some View {
        Image("artist_\(artist.artistId)")
            .resizable()
            .scaledToFit()
            .clipShape(.rect(cornerRadius: 20.0))
            .padding(.horizontal, 16.0)
    }
    @ViewBuilder
    private func artistSocialsView() -> some View {
        HStack(spacing: 20.0) {
            if !facebookLink.isEmpty {
                Link(destination: URL(string: facebookLink)!) {
                    Image(.facebook)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60.0, height: 60.0)
                }
            }
            if !instagramLink.isEmpty {
                Link(destination: URL(string: instagramLink)!) {
                    Image(.instagram)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60.0, height: 60.0)
                }
            }
        }
    }
    @ViewBuilder
    private func artistGalleryView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12.0) {
                ForEach(galleries) { gallery in
                    if let art = getArt(for: gallery) {
                        galleryArtView(art)
                            .onTapGesture {
                                selectedGallery = gallery
                            }
                    }
                }
                .scrollTransition(.animated(.spring), axis: .horizontal) { content, phase in
                    content
                        .opacity(phase.isIdentity ? 1.0 : 0.80)
                        .scaleEffect(phase.isIdentity ? 1.0 : 0.90)
                }
            }.padding(.horizontal, 16.0)
        }
    }
    @ViewBuilder
    private func galleryArtView(_ art: Art) -> some View {
        Image("\(art.artId)")
            .resizable()
            .scaledToFill()
            .frame(width: 320.0, height: 200.0)
            .clipShape(.rect(cornerRadius: 20.0))
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
        ArtistDetailsView(
            artist: Artist.previewList[5]
        )
    }
    .environment(artGalleryModel)
}
