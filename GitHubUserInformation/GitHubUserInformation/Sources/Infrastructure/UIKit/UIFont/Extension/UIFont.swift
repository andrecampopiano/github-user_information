//
//  UIFont.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 22/05/23.
//

import UIKit

extension UIFont {
    
    convenience init?(name: FontStyleAndName, size: FontSize) {
        self.init(name: name.rawValue, size: size.rawValue)
    }
    
    convenience init?(name: FontStyleAndName, size: CGFloat) {
        self.init(name: name.rawValue, size: size)
    }
}
