//
//  Artist.swift
//  ArtGallery
//
//  Created by Dylan on 26/01/2025.
//

import Foundation

struct Artist: Decodable, Identifiable, Hashable, Equatable {
    enum CodingKeys: String, CodingKey {
        case artistId = "ArtistId"
        case artistName = "ArtistName"
        case social = "Social"
    }
    let artistId: Int
    let artistName: String
    let social: [Social]
    var id: Int { artistId }
}
