//
//  Bundle.swift
//  GitHubUserInformationTests
//
//  Created by Andre Luis Campopiano on 22/05/23.
//

import Foundation

extension Bundle {
    
    /// Get module bundle
    static var getBundleVirtualTechSupport: Bundle {
        return Bundle(for: GitHubUserInformationTests.self)
    }
}
