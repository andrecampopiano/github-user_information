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
        guard let homeViewController = buildHomeViewController() else { return false }
        let navigationController = UINavigationController(rootViewController: homeViewController)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        return true
    }
    
    private func buildHomeViewController() -> HomeViewController? {
        let viewModel = HomeViewModel()
        return HomeViewController.instantiate(viewModel: viewModel)
    }
}
