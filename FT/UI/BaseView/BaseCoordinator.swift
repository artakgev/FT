//
//  BaseCoordinator.swift
//  FT
//
//  Created by Artak Gevorgyan on 12 Oct, 2023
//  Copyright © 2023 Artak Gevorgyan. All rights reserved.
//

import UIKit

protocol CoordinatorBaseProtocol: AnyObject {

    /// Pop view from navigation controller stack
    func goBack()

    /// Dismiss presented view
    func dismiss()
}

class Coordinator {
    
    var navigationController: UINavigationController!
    
    func start() {
        let splashVC = StoryboardScene.SplashView.splashVC.instantiate()
        let vm = SplashVM()
        splashVC.vm = vm
        vm.coordinator = self
        navigationController.show(splashVC, sender: self)
    }

    func goBack() {
        self.navigationController.popViewController(animated: true)
    }

    func dismiss() {
        navigationController.dismiss(animated: true)
    }

}

extension Coordinator: BaseVCCoordinatorProtocol {

//    func openAuthView() {
//        let vc = StoryboardScene.Auth.authVC.instantiate()
//        let vm = AuthVM()
//        vc.vm = vm
//        vm.coordinator = self
//        navigationController.setViewControllers([vc], animated: true)
//    }
    
    func openLoginView() {
//        let vc = StoryboardScene.Login.loginVC.instantiate()
//        let vm = LoginVM()
//        vm.coordinator = self
//        vm.baseCoordinator = self
//        vc.vm = vm
//        navigationController.setViewControllers([vc], animated: true)
    }
}
