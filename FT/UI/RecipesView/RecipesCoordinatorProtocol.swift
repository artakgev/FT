//
//  RecipesCoordinator.swift
//  FT
//
//  Created by Artak Gevorgyan on 14.11.23.
//  Copyright © 2023 Artak Gevorgyan. All rights reserved.
//

protocol RecipesCoordinatorProtocol: CoordinatorBaseProtocol {

    func openRecipeDetailsView(recipe: Recipe)
}

extension Coordinator: RecipesCoordinatorProtocol {
    
    func openRecipeDetailsView(recipe: Recipe) {
        let vc = StoryboardScene.Main.recipeDetailsVC.instantiate()
        let vm = RecipeDetailsVM(withRecipe: recipe)
        vc.vm = vm
        navigationController.pushViewController(vc, animated: true)
    }
}
