//
//  HomeCoordinator.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 07/06/23.
//

import CoreSwift
import Foundation

class HomeCoordinator: BaseCoordinator {
    
    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let controllerFactory: ControllerFactoryProtocol
    
    // MARK: - Initialize
    
    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, controllerFactory: ControllerFactoryProtocol) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.controllerFactory = controllerFactory
        super.init()
    }
    
    // MARK: - Override Methods
    
    override func start() {
        self.showHomeController()
    }
    
    private func showHomeController() {
        let viewController = self.controllerFactory.instantiate()
        self.router.setRootViewController(viewController, hideBar: false)
    }
}
