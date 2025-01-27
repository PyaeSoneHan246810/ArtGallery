//
//  TabsView.swift
//  ArtGallery
//
//  Created by Dylan on 26/01/2025.
//

import SwiftUI

struct TabsView: View {
    // MARK: - STATE PROPERTIES
    @State private var artGalleryModel: ArtGalleryModel = ArtGalleryModel()
    @State private var error: LocalizedError?
    
    // MARK: - BODY
    var body: some View {
        Group {
            if let error {
                ContentUnavailableView(
                    "Unable to load data!",
                    systemImage: "exclamationmark.triangle.fill",
                    description: Text(error.localizedDescription)
                )
            } else {
                TabView {
                    Tab("Arts", systemImage: "photo.fill") {
                        NavigationStack {
                            ArtsView()
                        }
                    }
                    Tab("Artists", systemImage: "person.3.fill") {
                        NavigationStack {
                            ArtistsView()
                        }
                    }
                }
            }
        }
        .onAppear {
            loadData()
        }
        .environment(artGalleryModel)
    }
    
    // MARK: - FUNCTIONS
    private func loadData() {
        do {
            let artGallery: ArtGallery = try Bundle.main.decodeJsonFile("ArtGallery")
            artGalleryModel.galleries = artGallery.galleries
            artGalleryModel.arts = artGallery.arts
            artGalleryModel.artists = artGallery.artists
        } catch {
            if let error = error as? LocalizedError {
                self.error = error
            }
        }
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    TabsView()
}
