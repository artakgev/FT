//
//  RecipesVM.swift
//  FT
//
//  Created by Artak Gevorgyan on 16.11.24.
//

import UIKit

final class RecipesVM: BaseVM {
    
    // MARK: - Public properties

    public weak var coordinator: RecipesCoordinatorProtocol?
    
    // MARK: - Public methods
    
    public func getRecipes() {
        let repo = RecipesRepo()
        repo.getRecipes { recipes, error in
            if error == nil {
                guard let result = recipes else { return }
                self.baseDelegate?.dataFetched(type: [Recipe].self, data: result, observerName: "")
            } else if let error = error {
                self.baseDelegate?.errorReceived(error: error)
            } else {
                print("____ ERROR _____: ", error)
            }
        }
    }

    public func openRecipeDetailsView(recipe: Recipe) {
        self.coordinator?.openRecipeDetailsView(recipe: recipe)
    }

}

