//
//  AppDelegate.swift
//  FT
//
//  Created by Artak Gevorgyan on 16.11.24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.setupLXCoreNetworkLayer()
        self.initBaseCoordinator()
        return true
    }
    
    private func setupLXCoreNetworkLayer() {
        let lxConstantsManageer = LXConstantsManager.shared
        lxConstantsManageer.setLXBaseUrl(Constants.baseUrl)
        lxConstantsManageer.setLXEnvironment(.debugTest)
    }
    
    private func initBaseCoordinator() {
        let navigationCon = StoryboardScene.SplashView.baseNavigationController.instantiate()
        window!.rootViewController = navigationCon
        window!.makeKeyAndVisible()
        appCoordinator = Coordinator()
        appCoordinator?.navigationController = navigationCon
        appCoordinator?.start()
    }

}

