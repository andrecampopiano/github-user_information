//
//  AppDelegate.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let viewController = buildHomeViewController() else { return false }
        let navigationController = buildNavigationController(viewController: viewController)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        return true
    }
    
    private func buildHomeViewController() -> HomeViewController? {
        let viewModel = HomeViewModel()
        return HomeViewController.instantiate(viewModel: viewModel)
    }
    
    private func buildNavigationController(viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        let standard = UINavigationBarAppearance()
        standard.configureWithOpaqueBackground()
        standard.backgroundColor = .neutralWhite
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        standard.backButtonAppearance = backButtonAppearance
        navigationController.navigationBar.standardAppearance = standard
        navigationController.navigationBar.scrollEdgeAppearance = standard
        navigationController.navigationBar.tintColor = .secondaryNavy
        return navigationController
    }
}
