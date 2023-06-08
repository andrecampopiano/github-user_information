//
//  AppDelegate.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import CoreSwift
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private var rootController: UINavigationController? {
        return self.window?.rootViewController as? UINavigationController
    }
    
    private lazy var applicationCoordinator: Coordinator = {
        return ApplicationCoordinator(router: Router(rootController: self.rootController), coordinatorFactory: CoordinatorFactory())
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = buildNavigationController()
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        applicationCoordinator.start()
        return true
    }
    
    private func buildNavigationController() -> UINavigationController {
        let navigationController = UINavigationController()
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
