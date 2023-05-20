//
//  LocalizableBundle.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

enum LocalizableBundle: String {
    
    // MARK: - Loading View
    case loadingViewTitle
    case loadingViewSubtitle
    
    var localize: String {
        return rawValue.localize(bundle: .main)
    }
}
