//
//  RecipeDetailsVM.swift
//  FT
//
//  Created by Artak Gevorgyan on 16.11.24.
//

import UIKit

final class RecipeDetailsVM: BaseVM {
    
    // MARK: - Public properties
    
    private(set) var recipeObject: Recipe
    
    // MARK: - Initialization
    
    init(withRecipe: Recipe) {
        self.recipeObject = withRecipe
    }

}

