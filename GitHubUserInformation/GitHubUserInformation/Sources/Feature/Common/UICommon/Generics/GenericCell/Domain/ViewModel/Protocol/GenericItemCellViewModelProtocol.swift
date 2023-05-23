//
//  GenericItemCellViewModelProtocol.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 23/05/23.
//

import Foundation

protocol GenericItemCellViewModelProtocol {
    var title: Dynamic<String?> { get }
    var description: Dynamic<String?> { get }
}
