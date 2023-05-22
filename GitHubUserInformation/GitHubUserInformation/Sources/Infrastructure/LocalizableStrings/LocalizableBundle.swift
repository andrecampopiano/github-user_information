//
//  LocalizableBundle.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

enum LocalizableBundle: String {
    
    // MARK: - Home View
    
    case homeViewControllerNavitationTitle
    
    // MARK: - Loading View
    case loadingViewTitle
    case loadingViewSubtitle
    
    // MARK: - Generic Erro Cell
    
    case genericErrorTitle
    case genericErrorSubtitle
    
    // MARK: - Generic Texts
    
    case tryAgainButton
    
    var localize: String {
        return rawValue.localize(bundle: .main)
    }
}
