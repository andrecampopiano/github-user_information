//
//  HomeCoordinatorFactory.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 07/06/23.
//

import CoreSwift
import Foundation

class HomeCoordinatorFactory: CoordinatorFactoryProtocol {
    func makeCoordinator(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, controllerFactory: ControllerFactoryProtocol) -> BaseCoordinator {
        return HomeCoordinator(router: router, coordinatorFactory: coordinatorFactory, controllerFactory: controllerFactory)
    }
}
