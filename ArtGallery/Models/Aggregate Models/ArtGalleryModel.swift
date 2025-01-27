//
//  ArtGalleryModel.swift
//  ArtGallery
//
//  Created by Dylan on 26/01/2025.
//

import Foundation
import Observation

@Observable
class ArtGalleryModel {
    init(galleries: [Gallery]? = nil, arts: [Art]? = nil, artists: [Artist]? = nil) {
        guard let galleries, let arts, let artists else {
            return
        }
        self.galleries = galleries
        self.arts = arts
        self.artists = artists
    }
    var galleries: [Gallery] = []
    var arts: [Art] = []
    var artists: [Artist] = []
}
