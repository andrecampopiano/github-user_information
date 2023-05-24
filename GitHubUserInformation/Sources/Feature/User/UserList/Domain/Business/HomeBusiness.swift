//
//  HomeBusiness.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import CoreSwift
import Foundation

typealias UserListGetCompletion = (Result<[UserResponse], Error>) -> Void

protocol HomeBusinessProtocol {
    func handleUserListGet(result: NetworkingResponse, completion: @escaping UserListGetCompletion)
}

struct HomeBusiness: HomeBusinessProtocol {
    
    private enum Constants {
        static let parseErrorDescription: String = "Error decoding data"
    }
    
    func handleUserListGet(result: NetworkingResponse, completion: @escaping UserListGetCompletion) {
        do {
            guard let response = try result().data else { return completion(.failure(BaseError.parse(Constants.parseErrorDescription))) }
            
            let model = try JSONDecoder().decode([UserResponse].self, from: response)
            completion(.success(model))
        } catch {
            completion(.failure(error))
        }
    }
}
