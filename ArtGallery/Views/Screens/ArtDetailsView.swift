//
//  ArtDetailsView.swift
//  ArtGallery
//
//  Created by Dylan on 26/01/2025.
//

import SwiftUI

struct ArtDetailsView: View {
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.dismiss) private var dismiss
    @Environment(ArtGalleryModel.self) private var artGalleryModel
    
    // MARK: - STATE PROPERTIES
    @State private var isArtImageFullScreenViewPresented: Bool = false
    
    // MARK: - PROPERTIES
    let artId: Int
    var artistId: Int
    
    // MARK: - COMPUTED PROPERTIES
    private var art: Art? {
        let art = artGalleryModel.arts.first(where: { $0.artId == artId})
        return art
    }
    private var artist: Artist? {
        let artist = artGalleryModel.artists.first(where: { $0.artistId == artistId})
        return artist
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .topLeading) {
            if let art {
                artDetailsScrollView(art)
            } else {
                ContentUnavailableView(
                    "Art not found!",
                    systemImage: "photo.badge.exclamationmark.fill"
                )
            }
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .imageScale(.large)
            }
            .padding(.leading, 20.0)
            .padding(.top, 10.0)
        }
        .navigationDestination(for: Artist.self) { artist in
            ArtistDetailsView(
                artist: artist
            )
        }
    }
    
    // MARK: - VIEW BUILDERS
    @ViewBuilder
    private func artDetailsScrollView(_ art: Art) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 24.0) {
                Image("\(art.artId)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        isArtImageFullScreenViewPresented.toggle()
                    }
                    .fullScreenCover(isPresented: $isArtImageFullScreenViewPresented) {
                        artImageFullScreenView("\(art.artId)")
                    }
                VStack(alignment: .leading, spacing: 12.0) {
                    Text(art.artName)
                        .font(.title)
                        .fontWeight(.semibold)
                    Text(art.unwrappedDescription)
                        .font(.body)
                        .lineSpacing(8.0)
                }
                .padding(.horizontal, 16.0)
                if let artist {
                    HStack(spacing: 12.0) {
                        NavigationLink(value: artist) {
                            Image("artist_\(artist.artistId)")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 72, height: 72)
                                .clipShape(.circle)
                        }
                        Text(artist.artistName)
                            .font(.headline)
                    }
                    .padding(.horizontal, 16.0)
                }
                Button("Back") {
                    dismiss()
                }
                .buttonStyle(.bordered)
                .padding(.horizontal, 16.0)
            }
        }
        .ignoresSafeArea()
    }
    @ViewBuilder
    private func artImageFullScreenView(_ imageResourceName: String) -> some View {
        ZStack {
            Image(imageResourceName)
                .resizable()
                .scaledToFit()
                .clipShape(.rect(cornerRadius: 12.0))
                .shadow(radius: 4.0, x: 0, y: 4)
                .padding(20.0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .bottom) {
            Button("Back") {
                isArtImageFullScreenViewPresented.toggle()
            }
            .buttonStyle(.bordered)
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
        ArtDetailsView(
            artId: Gallery.previewList[0].artId,
            artistId: Gallery.previewList[0].artistId
        )
    }
    .environment(artGalleryModel)
}
