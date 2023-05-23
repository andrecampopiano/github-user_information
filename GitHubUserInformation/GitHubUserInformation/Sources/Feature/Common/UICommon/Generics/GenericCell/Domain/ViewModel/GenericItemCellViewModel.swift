//
//  GenericItemCellViewModel.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 23/05/23.
//

import Foundation

class GenericItemCellViewModel: GenericItemCellViewModelProtocol {
    
    // MARK: - Properties
    
    var title = Dynamic<String?>(nil)
    var description = Dynamic<String?>(nil)
    
    required init(model: GenericItemModel) {
        self.title.value = model.title
        self.description.value = model.description
    }
}
