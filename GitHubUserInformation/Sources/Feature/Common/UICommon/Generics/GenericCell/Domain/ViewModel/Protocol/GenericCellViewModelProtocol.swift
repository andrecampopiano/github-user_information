//
//  GenericCellViewModelProtocol.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import CoreSwift
import Foundation

protocol GenericCellViewModelProtocol {
    var title: Dynamic<String?> { get }
    var subtitle: Dynamic<String?> { get }
    var description: Dynamic<String?> { get }
    var imageUrl: Dynamic<String?> { get }
}
