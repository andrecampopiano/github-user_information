//
//  HomeManager.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import CoreSwift
import Foundation

protocol HomeManagerProtocol {
    func fetchUserList(completion: @escaping UserListGetCompletion)
}

final class HomeManager: BaseManager, HomeManagerProtocol {
    
    // MARK: - Properties
    
    private var business: HomeBusinessProtocol?
    private var provider: ApiProviderProtocol?
    
    // MARK: - Initialize
    
    init(business: HomeBusinessProtocol? = HomeBusiness(), provider: ApiProviderProtocol? = nil) {
        self.business = business
        self.provider = provider
    }
    
    // MARK: - Public Methods
    
    func fetchUserList(completion: @escaping UserListGetCompletion) {
        cancelAllOperations()
        let operation = UserListGetOperation(provider: self.provider, business: self.business, completion: completion)
        addOperation(operation)
    }
}
