//
//  Social.swift
//  ArtGallery
//
//  Created by Dylan on 26/01/2025.
//

import Foundation

struct Social: Decodable, Identifiable, Hashable, Equatable {
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case link = "Link"
    }
    let name: String
    let link: String
    var id: String { link }
}
