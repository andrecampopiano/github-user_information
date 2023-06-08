//
//  HomeControllerFactory.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 07/06/23.
//

import CoreSwift
import UIKit

class HomeControllerFactory: ControllerFactoryProtocol {
    func instantiate() -> UIViewController? {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController.instantiate(viewModel: viewModel)
        return viewController
    }
}
