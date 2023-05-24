//
//  UserDetailsGetOperation.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 23/05/23.
//

import CoreSwift
import Foundation

class UserDetailsGetOperation: NetworkingOperation {
    
    // MARK: - Constants
    
    private enum Constants {
        static let urlPathFormat: String = "%@/%@"
    }
    
    // MARK: - Properties
    
    var completion: UserDetailsGetCompletion
    var business: UserDetailsBusinessProtocol?
    var userName: String?
    
    // MARK: - Initialize
    
    required init(userName: String? = nil, provider: ApiProviderProtocol? = nil, business: UserDetailsBusinessProtocol? = nil, completion: @escaping UserDetailsGetCompletion) {
        self.completion = completion
        self.business = business
        self.userName = userName
        super.init(provider: provider)
    }
    
    override func main() {
        super.main()
        provider?.baseRequest(requestData: setupNetworkingRequestData()) { [weak self] result in
            guard let self = self else { return }
            self.business?.handleUserDetailsGetCompletion(result: result, completion: self.completion)
            self.finish()
        }
    }
    
    private func setupNetworkingRequestData() -> NetworkingRequestData {
        let urlPath = String(format: Constants.urlPathFormat, ApplicationConstants.PathApi().user, userName ?? String())
        return NetworkingRequestData(url: urlPath, httpMethod: .get)
    }
}
