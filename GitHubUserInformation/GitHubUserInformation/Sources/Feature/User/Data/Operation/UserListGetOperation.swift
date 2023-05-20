//
//  UserListGetOperation.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

final class UserListGetOperation: NetworkingOperation {
    
    // MARK: - Properties
    
    private var completion: UserListGetCompletion
    private var business: HomeBusinessProtocol?
    
    // MARK: - Initialize
    
    required init(provider: ApiProviderProtocol? = nil, business: HomeBusinessProtocol?, completion: @escaping UserListGetCompletion) {
        self.completion = completion
        self.business = business
        super.init(provider: provider)
    }
    
    // MARK: - Override Methods
    
    override func main() {
        super.main()
        provider?.baseRequest(requestData: setupNetworkingRequestData()) { [weak self] result in
            guard let self = self else { return }
            self.business?.handleUserListGet(result: result, completion: self.completion)
            self.finish()
        }
    }
    
    // MARK: - Private Methods
    
    private func setupNetworkingRequestData() -> NetworkingRequestData {
        return NetworkingRequestData(url: ApplicationConstants.PathApi().user, httpMethod: .get)
    }
}
