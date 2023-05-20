//
//  HomeViewController.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: HomeViewModelProtocol?
    
    // MARK: - Instantiate
    
    static func instantiate(viewModel: HomeViewModelProtocol) -> HomeViewController {
        let viewController = HomeViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchUserList()
    }
}
