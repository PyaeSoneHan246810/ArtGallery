//
//  Art.swift
//  ArtGallery
//
//  Created by Dylan on 26/01/2025.
//

import Foundation

struct Art: Decodable {
    enum CodingKeys: String, CodingKey {
        case artId = "ArtId"
        case artName = "ArtName"
        case artDescription = "ArtDescription"
    }
    let artId: Int
    let artName: String
    let artDescription: String?
    var id: Int { artId }
    var unwrappedDescription: String { artDescription ?? "No description available." }
}
