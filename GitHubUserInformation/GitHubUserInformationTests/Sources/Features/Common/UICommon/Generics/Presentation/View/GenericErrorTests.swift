//
//  GenericErrorTests.swift
//  GitHubUserInformationTests
//
//  Created by Andre Luis Campopiano on 22/05/23.
//

@testable import GitHubUserInformation
import XCTest

class GenericErrorTests: BaseXCTest, Elements {
    
    typealias ElementsId = GenericErrorCellIdentifiers
    
    // MARK: - Elements
    
    private var titleLabel: UILabel?
    private var mainImageView: UIImageView?
    private var descriptionLabel: UILabel?
    private var tryAgainButton: UIButton?
    
    // MARK: - Properties
    
    private var sut: GenericErrorCell?
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
        XCTAssertEqual(titleLabel?.text, "Ops! Erro ao carregar")
        XCTAssertEqual(descriptionLabel?.text, "Estamos passando por uma instabilidade, por favor tente novamente.")
        XCTAssertEqual(tryAgainButton?.titleLabel?.text, "Tentar Novamente")
    }
    
    func test_custom_values() {
        makeSut(title: "Algo deu Errado", description: "Estamos com problemas", imageName: "icon_basic_circle_x", buttonName: "Tentar outra vez!")
        XCTAssertEqual(titleLabel?.text, "Algo deu Errado")
        XCTAssertEqual(descriptionLabel?.text, "Estamos com problemas")
        XCTAssertEqual(tryAgainButton?.titleLabel?.text, "Tentar outra vez!")
    }
    
    func test_snapshot_with_default_values() {
        makeSut()
        sut?.frame = CGRect(x: .zero, y: .zero, width: 320, height: 380)
        verifySnapshotView(delay: 2) {
            self.sut
        }
    }
    
    func test_snapshot_with_custom_values() {
        makeSut(title: "Algo deu Errado", description: "Estamos com problemas", imageName: "icon_basic_circle_x", buttonName: "Tentar outra vez!")
        sut?.frame = CGRect(x: .zero, y: .zero, width: 320, height: 350)
        verifySnapshotView(delay: 2) {
            self.sut
        }
    }
    
    // MARK: - Private Methods
    
    private func makeSut(title: String? = nil, description: String? = nil, imageName: String? = nil, buttonName: String? = nil) {
        sut = GenericErrorCell.instantiate()
        sut?.setup(title: title, description: description, imageName: imageName, buttonName: buttonName)
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
        mainImageView = findElement(in: sut, andIdentifier: .mainImageView)
        tryAgainButton = findElement(in: sut, andIdentifier: .tryAgainButton)
    }
}
