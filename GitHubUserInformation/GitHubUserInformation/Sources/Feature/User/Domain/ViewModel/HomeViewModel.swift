//
//  HomeViewModel.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

enum StatusApi {
    case loading
    case loaded
    case error
}

protocol HomeViewModelProtocol {
    
    var model: [UserResponse]? { get }
    var status: Dynamic<StatusApi?> { get }
    
    init(manager: HomeManagerProtocol?)
    
    func fetchUserList()
}

final class HomeViewModel: HomeViewModelProtocol {
    
    // MARK: - Properties
    
    var model: [UserResponse]?
    var status = Dynamic<StatusApi?>(nil)
    private var manager: HomeManagerProtocol?
    
    // MARK: - Initialize
    
    required init(manager: HomeManagerProtocol? = HomeManager()) {
        self.manager = manager
    }
    
    // MARK: - Public Methods
    
    func fetchUserList() {
        self.status.value = .loading
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
    
    private func handleSuccess(model: [UserResponse]) {
        self.model = model
        self.status.value = .loaded
    }
    
    private func handleError(error: Error) {
        self.status.value = .error
    }
}
