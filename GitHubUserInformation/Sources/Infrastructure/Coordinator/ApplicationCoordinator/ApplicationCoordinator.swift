//
//  ApplicationCoordinator.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 07/06/23.
//

import CoreSwift
import Foundation

typealias ControllerFactory = HomeControllerFactory

class ApplicationCoordinator: BaseCoordinator {
    
    // MARK: - Properties
    
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let router: RouterProtocol
    private let controllerFactory: ControllerFactoryProtocol = ControllerFactory()
    
    // MARK: - Initialize
    
    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    // MARK: - Override Methods
    
    override func start() {
        showHomeFlow()
    }
    
    // MARK: - Private Methods
    
    private func showHomeFlow() {
        let coordinator = self.coordinatorFactory.makeCoordinator(router: router,
                                                                  coordinatorFactory: coordinatorFactory,
                                                                  controllerFactory: controllerFactory)
        addDependency(coordinator)
        coordinator.start()
    }
}
