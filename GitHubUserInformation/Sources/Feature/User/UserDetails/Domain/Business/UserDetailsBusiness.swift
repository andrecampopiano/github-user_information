//
//  UserDetailsBusiness.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 23/05/23.
//

import CoreSwift
import Foundation

typealias UserDetailsGetCompletion = (Result<UserResponse, Error>) -> Void

protocol UserDetailsBusinessProtocol {
    func handleUserDetailsGetCompletion(result: NetworkingResponse, completion: @escaping UserDetailsGetCompletion)
}

struct UserDetailsBusiness: UserDetailsBusinessProtocol {
    
    // MARK: - Constants
    
    private enum Constants {
        static let parseErrorDescription: String = "Error decoding data"
    }
    
    // MARK: - Public Methods
    
    func handleUserDetailsGetCompletion(result: NetworkingResponse, completion: @escaping UserDetailsGetCompletion) {
        do {
            guard let response = try result().data else { return completion(.failure(BaseError.parse(Constants.parseErrorDescription))) }
            let model = try JSONDecoder().decode(UserResponse.self, from: response)
            completion(.success(model))
        } catch {
            completion(.failure(error))
        }
    }
}
