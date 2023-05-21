//
//  BaseXCTest.swift
//  GitHubUserInformationTests
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import FBSnapshotTestCase
import Foundation

open class BaseXCTest: FBSnapshotTestCase {
    
    // MARK: - Override
    
    override open func setUp() {
        super.setUp()
        recordMode = false
    }
    
    // MARK: - Public methods
    
    public func addControllerToWindow(_ controller: UIViewController) {
        let window = UIWindow()
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
    
    public func verifySnapshotView(delay: TimeInterval = 0, tolerance: CGFloat = 0, identifier: String = "", file: StaticString = #file, line: UInt = #line, framesToRemove: [CGRect] = [], forceHideKeyboard: Bool = true, view: @escaping () -> UIView?) {
        sleepTest(for: delay)
        
        guard let view = view() else {
            XCTFail("could not fetch view", file: file, line: line)
            return
        }
        
        if forceHideKeyboard {
            view.endEditing(true)
        }
        
        var image = view.asImage
        
        if !framesToRemove.isEmpty {
            image = image.addImageWithFrame(frames: framesToRemove) ?? UIImage()
        }
        
        folderName = customFolderName(file: file)
        let customIdentifier = "\(identifier)_\("iPhone8".replacingOccurrences(of: " ", with: ""))"
        FBSnapshotVerifyView(UIImageView(image: image), identifier: customIdentifier, suffixes: NSOrderedSet(array: ["_64"]), perPixelTolerance: 0.005, overallTolerance: tolerance, file: file, line: line)
    }
    
    public func sleepTest(for delay: TimeInterval, file: StaticString = #file, line: UInt = #line) {
        guard delay > 0 else { return }
        let delayExpectation = XCTestExpectation(description: "failed to wait for " + String(delay))
        delayExpectation.assertForOverFulfill = true
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            delayExpectation.fulfill()
        }
        wait(for: [delayExpectation], timeout: 1 + delay)
    }
    
    // MARK: - Private methods
    
    private func cleanIdentifier(identifier: String) -> String {
        var deviceName = UIDevice.current.name
        
        if deviceName.contains("Clone") {
            for index in 0 ... 6 {
                deviceName = deviceName.replacingOccurrences(of: "Clone \(index) of", with: "")
            }
        }
        
        deviceName = deviceName.replacingOccurrences(of: " ", with: "")
        
        return "\(identifier)_\(deviceName)"
    }
    
    private func customFolderName(file: StaticString) -> String {
        let fileName = String(describing: type(of: self))
        let methodName: String = invocation?.selector.description ?? ""
        return "\(fileName)/\(methodName)"
    }
}
