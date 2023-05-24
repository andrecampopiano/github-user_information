//
//  UserDetailsRouter.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 23/05/23.
//

import UIKit

final class UserDetailsRouter {
    
    // MARK: - Properties
    
    private var navigationController: UINavigationController?
    
    // MARK: Initializer
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public Methods
    
    func start(userName: String?) {
        let viewModel = UserDetailsViewModel(userName: userName)
        let viewController = UserDetailsViewController.instantiate(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
