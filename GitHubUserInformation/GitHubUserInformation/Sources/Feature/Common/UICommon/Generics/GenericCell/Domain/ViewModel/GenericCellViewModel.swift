//
//  GenericCellViewModel.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

class GenericCellViewModel: GenericCellViewModelProtocol {
    var title = Dynamic<String?>(nil)
    var subtitle = Dynamic<String?>(nil)
    var imageUrl = Dynamic<String?>(nil)
    
    required init(model: GenericCellModel?) {
        self.title.value = model?.title
        self.subtitle.value = model?.subtitle
        if let imageUrl = model?.imageUrl {
            self.imageUrl.value = imageUrl
        } else {
            self.imageUrl.value = String()
        }
    }
}
