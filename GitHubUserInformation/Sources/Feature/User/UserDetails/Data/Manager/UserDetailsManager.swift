//
//  UserDetailsManager.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 23/05/23.
//

import CoreSwift
import Foundation

protocol UserDetailsManagerProtocol {
    func fetchUser(userName: String?, completion: @escaping UserDetailsGetCompletion)
}

final class UserDetailsManager: BaseManager, UserDetailsManagerProtocol {
    
    // MARK: - Properties
    
    private var provider: ApiProviderProtocol?
    private var business: UserDetailsBusinessProtocol?
    
    init(provider: ApiProviderProtocol? = nil, business: UserDetailsBusinessProtocol? = UserDetailsBusiness()) {
        self.business = business
        self.provider = provider
        super.init()
    }
    
    func fetchUser(userName: String?, completion: @escaping UserDetailsGetCompletion) {
        cancelAllOperations()
        let operation = UserDetailsGetOperation(userName: userName, provider: provider, business: business, completion: completion)
        addOperation(operation)
    }
}
