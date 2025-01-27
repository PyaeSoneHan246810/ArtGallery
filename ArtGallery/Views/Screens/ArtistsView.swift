//
//  ArtistsView.swift
//  ArtGallery
//
//  Created by Dylan on 26/01/2025.
//

import SwiftUI

struct ArtistsView: View {
    // MARK: - PROPERTIES
    @Environment(ArtGalleryModel.self) private var artGalleryModel
    
    // MARK: - STATE PROPERTIES
    @State private var selectedArtist: Artist?
    
    // MARK: - COMPUTED PROPERTIES
    private var artists: [Artist] {
        artGalleryModel.artists
    }
    
    // MARK: - BODY
    var body: some View {
        TabView {
            ForEach(artists) { artist in
                artistTabItemView(artist)
                    .onTapGesture {
                        selectedArtist = artist
                    }
            }
            .padding(.horizontal, 16.0)
        }
        .tabViewStyle(.page)
        .shadow(radius: 4.0, x: 0, y: 4)
        .padding(.vertical, 40.0)
        .navigationTitle("Artists")
        .fullScreenCover(item: $selectedArtist) { artist in
            NavigationStack {
                ArtistDetailsView(
                    artist: artist
                )
            }
        }
    }
    
    // MARK: - VIEW BUILDERS
    @ViewBuilder
    private func artistTabItemView(_ artist: Artist) -> some View {
        RoundedRectangle(cornerRadius: 20.0)
            .fill(.black)
            .overlay {
                Image("artist_\(artist.artistId)")
                    .resizable()
                    .scaledToFill()
                    .overlay {
                        Rectangle()
                            .fill(.black)
                            .opacity(0.2)
                            .blur(radius: 4.0)
                    }
            }
            .clipShape(.rect(cornerRadius: 20.0))
            .overlay(alignment: .bottomLeading) {
                Text(artist.artistName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.leading, 20.0)
                    .padding(.bottom, 40.0)
            }
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
        ArtistsView()
    }
    .environment(artGalleryModel)
}
