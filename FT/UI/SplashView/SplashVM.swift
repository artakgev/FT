//
//  SplashVM.swift
//  FT
//
//  Created by Artak Gevorgyan on 16.11.24.
//

import UIKit

final class SplashVM: BaseVM {
    
    // MARK: - Public properties

    weak var coordinator: SplashCoordinator?

    // MARK: - Public
    // MARK: Coordinator methods

    func openRecipesView() {
        coordinator?.openRecipesView()
    }
    
}

