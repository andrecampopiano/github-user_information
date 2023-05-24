//
//  XCTestExtensionView.swift
//  GitHubUserInformationTests
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation
import XCTest

extension UIView {
    
    // MARK: - Public properties
    
    /// asImage
    public var asImage: UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
        
    }
    
    /// subviewsRecursive
    public var subviewsRecursive: [UIView] {
        return subviews + subviews.flatMap { $0.subviewsRecursive }
    }
    
    // MARK: - Public methods
    
    /// Find view with identifier
    /// - Parameters:
    ///   - identifier: identifier
    /// - Returns: view
    public func viewWith<T: UIView>(accessibilityIdentifier identifier: String, file: StaticString = #file, line: UInt = #line) -> T {
        guard let view = viewWith(accessibilityIdentifier: identifier) else {
            XCTFail("view: \(identifier) was not found", file: file, line: line)
            return T()
        }
        
        guard let tempView = view as? T else {
            XCTFail("cast failed, expected \(String(describing: T.self)), but got \(type(of: view))", file: file, line: line)
            return T()
        }
        return tempView
    }
    
    /// Find view
    /// - Parameter identifier: identifier
    /// - Returns: view
    public func view(withAccessibilityIdentifier identifier: String) -> UIView {
        return viewWith(accessibilityIdentifier: identifier)
    }
    
    /// Find label
    /// - Parameter identifier: identifier
    /// - Returns: label
    public func label(withAccessibilityIdentifier identifier: String) -> UILabel {
        return viewWith(accessibilityIdentifier: identifier) as UILabel
    }
    
    /// Find button
    /// - Parameter identifier: identifier
    /// - Returns: button
    public func button(withAccessibilityIdentifier identifier: String) -> UIButton {
        return viewWith(accessibilityIdentifier: identifier) as UIButton
    }
    
    /// Find textField
    /// - Parameter identifier: identifier
    /// - Returns: textField
    public func textField(withAccessibilityIdentifier identifier: String) -> UITextField {
        return viewWith(accessibilityIdentifier: identifier)
    }
    
    /// Find segmentControl
    /// - Parameter identifier: identifier
    /// - Returns: segmentControl
    public func segmentControl(withAccessibilityIdentifier identifier: String) -> UISegmentedControl {
        return viewWith(accessibilityIdentifier: identifier) as UISegmentedControl
    }
    
    /// Find views with identifiers
    /// - Parameter accessibilityIdentifier: identifier string
    public func viewsWith(accessibilityIdentifier: String) -> [UIView]? {
        var views: [UIView] = []
        
        if self.accessibilityIdentifier == accessibilityIdentifier {
            views.append(self)
            
            return views
        }
        
        for subview in subviews {
            if let result = subview.viewWith(accessibilityIdentifier: accessibilityIdentifier) {
                views.append(result)
            }
        }
        
        return views
    }
    
    /// Find view with identifiers
    /// - Parameter accessibilityIdentifier: identifier string
    public func viewWith(accessibilityIdentifier: String) -> UIView? {
        if self.accessibilityIdentifier == accessibilityIdentifier || accessibilityLabel == accessibilityIdentifier {
            return self
        }
        
        for subview in subviews {
            if let result = subview.viewWith(accessibilityIdentifier: accessibilityIdentifier) {
                return result
            }
        }
        
        return nil
    }
}
