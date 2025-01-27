//
//  ArtGallery.swift
//  ArtGallery
//
//  Created by Dylan on 26/01/2025.
//

import Foundation

struct ArtGallery: Decodable {
    enum CodingKeys: String, CodingKey {
        case galleries = "Tbl_Gallery"
        case arts = "Tbl_Art"
        case artists = "Tbl_Artist"
    }
    let galleries: [Gallery]
    let arts: [Art]
    let artists: [Artist]
}
