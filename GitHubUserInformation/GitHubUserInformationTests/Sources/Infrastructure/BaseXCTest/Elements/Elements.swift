//
//  Elements.swift
//  GitHubUserInformationTests
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import UIKit

/// Elements protocol
protocol Elements {
    /// Elements Id enum
    associatedtype ElementsId: RawRepresentable where ElementsId.RawValue == String
}

extension Elements {
    /// Find an element in view
    /// - Parameters:
    ///   - type: View type
    ///   - identifier: accessibility identifier
    func findElement<T: UIView>(in view: UIView?, andIdentifier identifier: ElementsId) -> T? where ElementsId.RawValue == String {
        return view?.viewWith(accessibilityIdentifier: identifier.rawValue) as? T
    }
}
