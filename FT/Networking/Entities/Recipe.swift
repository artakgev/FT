//
//  Recipe.swift
//  FT
//
//  Created by Areg on 11/14/23.
//  Copyright © 2023 Artak Gevorgyan. All rights reserved.
//

import Foundation

struct Recipe: Codable {
    let photoUrlSmall: String?
    let uuid: String?
    let photoUrlLarge: String?
    let cuisine: String?
    let youtubeUrl: String?
    let name: String?
    let sourceUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case photoUrlSmall = "photo_url_small"
        case uuid
        case photoUrlLarge = "photo_url_large"
        case cuisine
        case youtubeUrl = "youtube_url"
        case name
        case sourceUrl = "source_url"
    }

}
