//
//  Gallery.swift
//  ArtGallery
//
//  Created by Dylan on 26/01/2025.
//

import Foundation

struct Gallery: Decodable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case galleryId = "GalleryId"
        case artistId = "ArtistId"
        case artId = "ArtId"
    }
    let galleryId: Int
    let artistId: Int
    let artId: Int
    var id: Int { galleryId }
}
