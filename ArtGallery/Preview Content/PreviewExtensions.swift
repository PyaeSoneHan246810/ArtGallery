//
//  PreviewExtensions.swift
//  ArtGallery
//
//  Created by Dylan on 26/01/2025.
//

import Foundation

extension Gallery {
    static var previewList: [Gallery] {
        guard let artGallery: ArtGallery = try? Bundle.main.decodeJsonFile("ArtGallery") else {
            return []
        }
        return artGallery.galleries
    }
}

extension Art {
    static var previewList: [Art] {
        guard let artGallery: ArtGallery = try? Bundle.main.decodeJsonFile("ArtGallery") else {
            return []
        }
        return artGallery.arts
    }
}

extension Artist {
    static var previewList: [Artist] {
        guard let artGallery: ArtGallery = try? Bundle.main.decodeJsonFile("ArtGallery") else {
            return []
        }
        return artGallery.artists
    }
}
