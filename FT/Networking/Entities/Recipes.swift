//
//  Recipes.swift
//  FT
//
//  Created by Areg on 11/14/23.
//  Copyright © 2023 Artak Gevorgyan. All rights reserved.
//

import Foundation

struct Recipes: Codable {
    let recipes: [Recipe]?
    
    enum CodingKeys: String, CodingKey {
        case recipes = "recipes"
    }

}
