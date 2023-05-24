//
//  GenericLoadingCellTests.swift
//  GitHubUserInformationTests
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

@testable import GitHubUserInformation
import XCTest

class GenericLoadingCellTests: BaseXCTest, Elements {
    
    typealias ElementsId = GenericLoadingCellIdentifiers
    
    // MARK: - Elements
    
    private var titleLabel: UILabel?
    private var descriptionLabel: UILabel?
    
    // MARK: - Properties
    
    private var sut: GenericLoadingCell?
    private var viewController: UIViewController?
    
    // MARK: - Override Methods
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        viewController = nil
    }
    
    // MARK: - Tests Methods
    
    func test_default_values() {
        makeSut()
        setViewController(sut: sut)
        XCTAssertEqual(titleLabel?.text, "Carregando")
        XCTAssertEqual(descriptionLabel?.text, "Estamos carregando suas informações!")
    }
    
    func test_custom_values() {
        makeSut(title: "Loading", description: "We are uploading your information!")
        setViewController(sut: sut)
        XCTAssertEqual(titleLabel?.text, "Loading")
        XCTAssertEqual(descriptionLabel?.text, "We are uploading your information!")
    }
    
    func test_snapshot_with_default_values() {
        makeSut()
        sut?.frame = CGRect(x: .zero, y: .zero, width: 320, height: 300)
        verifySnapshotView(delay: 2) {
            self.sut
        }
    }
    
    func test_snapshot_with_custom_values() {
        makeSut(title: "Loading", description: "We are uploading your information!")
        sut?.frame = CGRect(x: .zero, y: .zero, width: 320, height: 300)
        verifySnapshotView(delay: 2) {
            self.sut
        }
    }
    
    // MARK: - Private Methods
    
    private func makeSut(title: String? = nil, description: String? = nil) {
        sut = GenericLoadingCell.instantiate()
        sut?.setup(title: title, description: description)
        setupElements()
    }
    
    private func setViewController(sut: UIView?) {
        viewController = UIViewController()
        guard let viewController = viewController else { return }
        viewController.view = sut
        viewController.viewDidLoad()
        addControllerToWindow(viewController)
    }
    
    private func setupElements() {
        titleLabel = findElement(in: sut, andIdentifier: .titleLabel)
        descriptionLabel = findElement(in: sut, andIdentifier: .descriptionLabel)
    }
}
