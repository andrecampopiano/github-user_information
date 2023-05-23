//
//  UserDetailsViewModel.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 23/05/23.
//

import Foundation

protocol UserDetailsViewModelProtocol {
    
    var status: Dynamic<StatusApi?> { get }
    var model: UserResponse? { get }
    
    func fetchUserDetails()
}

class UserDetailsViewModel: UserDetailsViewModelProtocol {
   
    // MARK: - Properties
    var model: UserResponse?
    var status = Dynamic<StatusApi?>(nil)
    var manager: UserDetailsManagerProtocol?

    private var userName: String?
    
    init(manager: UserDetailsManagerProtocol? = UserDetailsManager(), userName: String?) {
        self.manager = manager
        self.userName = userName
    }
    
    // MARK: - Public Methods
    
    func fetchUserDetails() {
        self.status.value = .loading
        self.manager?.fetchUser(userName: userName) { result in
            switch result {
            case .success(let model):
                self.handleSuccess(model: model)
            case .failure(let error):
                self.handleError(error: error)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func handleSuccess(model: UserResponse) {
        self.model = model
        self.status.value = .loaded
    }
    
    private func handleError(error: Error) {
        self.status.value = .error
    }
}
