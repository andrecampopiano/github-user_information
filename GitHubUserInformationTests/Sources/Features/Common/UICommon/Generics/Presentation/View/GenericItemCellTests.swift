//
//  GenericItemCellTests.swift
//  GitHubUserInformationTests
//
//  Created by Andre Luis Campopiano on 23/05/23.
//

import CoreSwift
@testable import GitHubUserInformation
import XCTest

class GenericItemCellTests: BaseXCTest, Elements {
    
    typealias ElementsId = GenericItemCellIdentifiers
    
    private enum Constants {
        static let title: String = "Biografia:"
        static let descriptionSmallText: String = "Desenvolvedor iOS Senior pela BRQ"
        static let descriptionMediumText: String = "A 8 anos atuando como desenvolvedor mobile, focado no desenvolvimento de software iOS nativo"
        static let descriptionLargeText: String = "Iniciou sua carreira na area de desenvolvimento aos 30 anos como estagiario na empresa Cast Group, apos 4 meses foi efetivado e depois de 1 ano como efetivado, começou a desenvolver para aplicativos mobile, utilizando sua propria maquina, pois a empresa não queria investir em novos equipamentos e vendo a oportunidade começou a desenvolver aplicaçÕes iOS."
    }

    // MARK: - Elements
    
    private var titleLabel: UILabel?
    private var descriptionLabel: UILabel?
    
    // MARK: - Properties
    
    private var sut: GenericItemCell?
    private var viewModel: MokeGenericItemCellViewModel?
    
    // MARK: Override Methods
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    // MARK: - Tests Methods
    
    func test_assets() {
        makeViewModel(model: makeModel(title: Constants.title,
                                       description: Constants.descriptionMediumText))
        makeSut()
        XCTAssertEqual(titleLabel?.text, Constants.title)
        XCTAssertEqual(descriptionLabel?.text, Constants.descriptionMediumText)
    }
    
    func test_snapshot_with_descriptio_small_text() {
        makeViewModel(model: makeModel(title: Constants.title,
                                       description: Constants.descriptionSmallText))
        makeSut()
        verifySnapshotView(delay: 1) {
            self.sut
        }
    }
    
    func test_snapshot_with_descriptio_medium_text() {
        makeViewModel(model: makeModel(title: Constants.title,
                                       description: Constants.descriptionMediumText))
        makeSut(viewHeight: 150)
        verifySnapshotView(delay: 1) {
            self.sut
        }
    }
    
    func test_snapshot_with_descriptio_medium_large() {
        makeViewModel(model: makeModel(title: Constants.title,
                                       description: Constants.descriptionLargeText))
        makeSut(viewHeight: 285)
        verifySnapshotView(delay: 1) {
            self.sut
        }
    }
    
    // MARK: - Private Methods
    
    private func makeSut(viewHeight: CGFloat = 102) {
        sut = GenericItemCell.instantiate()
        guard let viewModel = viewModel else { return }
        sut?.setup(viewModel: viewModel)
        sut?.frame = CGRect(x: .zero, y: .zero, width: 320, height: viewHeight)
        setupElements()
    }
    
    private func makeViewModel(model: GenericItemModel) {
        viewModel = MokeGenericItemCellViewModel(model: model)
    }
    
    private func makeModel(title: String? = nil, description: String? = nil) -> GenericItemModel {
        return GenericItemModel(title: title, description: description)
    }
    
    private func setupElements() {
        titleLabel = findElement(in: sut, andIdentifier: .titleLabel)
        descriptionLabel = findElement(in: sut, andIdentifier: .descriptionLabel)
    }
}

private class MokeGenericItemCellViewModel: GenericItemCellViewModelProtocol {

    var title = Dynamic<String?>(nil)
    var description = Dynamic<String?>(nil)
    
    required init(model: GenericItemModel?) {
        title.value = model?.title
        description.value = model?.description
    }
}
