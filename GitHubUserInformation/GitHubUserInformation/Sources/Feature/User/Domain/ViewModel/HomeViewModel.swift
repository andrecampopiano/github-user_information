//
//  HomeViewModel.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

protocol HomeViewModelProtocol {
    
    init(manager: HomeManagerProtocol?)
    
    func fetchUserList()
}

final class HomeViewModel: HomeViewModelProtocol {
    
    // MARK: - Properties
    
    private var manager: HomeManagerProtocol?
    
    // MARK: - Initialize
    
    required init(manager: HomeManagerProtocol? = HomeManager()) {
        self.manager = manager
    }
    
    // MARK: - Public Methods
    
    func fetchUserList() {
        self.manager?.fetchUserList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.handleSuccess(model: model)
            case .failure(let error):
                self.handleError(error: error)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func handleSuccess(model: [UserResponse]) { }
    
    private func handleError(error: Error) { }
}
