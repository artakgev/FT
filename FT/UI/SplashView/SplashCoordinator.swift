//
//  SplashCoordinator.swift
//  FT
//
//  Created by Artak Gevorgyan on 14.11.23.
//  Copyright © 2023 Artak Gevorgyan. All rights reserved.
//

protocol SplashCoordinator: CoordinatorBaseProtocol {

    func openRecipesView()
}

extension Coordinator: SplashCoordinator {
    
    func openRecipesView() {
        let vc = StoryboardScene.Main.recipesVC.instantiate()
        let vm = RecipesVM()
        vm.coordinator = self
        vc.vm = vm
        navigationController.pushViewController(vc, animated: true)
    }
}
