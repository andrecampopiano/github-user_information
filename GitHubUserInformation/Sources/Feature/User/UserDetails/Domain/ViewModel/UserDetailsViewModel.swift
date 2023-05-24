//
//  UserDetailsViewModel.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 23/05/23.
//

import CoreSwift
import Foundation

protocol UserDetailsViewModelProtocol {
    
    var status: Dynamic<StatusApi?> { get }
    var model: GenericDetailsModel? { get }
    func fetchUserDetails()
}

class UserDetailsViewModel: UserDetailsViewModelProtocol {
    
    // MARK: - Properties
    var model: GenericDetailsModel?
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
            case .success(let response):
                self.handleSuccess(response: response)
            case .failure(let error):
                self.handleError(error: error)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func handleSuccess(response: UserResponse) {
        self.model = buildModel(response: response)
        self.status.value = .loaded
    }
    
    private func handleError(error: Error) {
        self.status.value = .error
    }
    
    private func buildModel(response: UserResponse) -> GenericDetailsModel {
        
        return GenericDetailsModel(title: response.name,
                                   subtitle: response.company,
                                   imageUrl: response.avatarUrl,
                                   description: response.htmlUrl,
                                   item: buildItemsModel(response: response))
    }
    
    private func buildItemsModel(response: UserResponse) -> [GenericItemModel] {
        var items = [GenericItemModel]()
        items.append(GenericItemModel(title: "Bio:", description: response.bio ?? "Não Informado"))
        items.append(GenericItemModel(title: "Login:", description: response.login ?? "Não Informado"))
        items.append(GenericItemModel(title: "Número de Respostiros Públicos:", description: String(response.publicRepos ?? 0)))
        items.append(GenericItemModel(title: "Localização:", description: response.location ?? "Não Informado"))
        items.append(GenericItemModel(title: "Email:", description: response.email ?? "Não Informado"))
        items.append(GenericItemModel(title: "Blog:", description: response.blog ?? "Não Informado"))
        items.append(GenericItemModel(title: "Twitter:", description: response.twitterUsername ?? "Não Informado"))
        items.append(GenericItemModel(title: "Seguidores:", description: String(response.followers ?? 0)))
        items.append(GenericItemModel(title: "Seguindo:", description: String(response.following ?? 0)))
        items.append(GenericItemModel(title: "Conta criada em:", description: response.createdAt ?? "Não Informado"))
        items.append(GenericItemModel(title: "Ultima atualização:", description: response.updatedAt ?? "Não Informado"))
        return items
    }
}
