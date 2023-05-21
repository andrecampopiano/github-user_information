//
//  GenericCellTests.swift
//  GitHubUserInformationTests
//
//  Created by Andre Luis Campopiano on 21/05/23.
//

@testable import GitHubUserInformation
import XCTest

class GenericCellTests: BaseXCTest, Elements {
    
    typealias ElementsId = GenericCellIdentifiers
    
    private enum Constants {
        static let imageUrl: String = "https://avatars.githubusercontent.com/u/8277291?v=4"
        static let title: String = "Andre Luis Campopiano"
        static let subtitle: String = "iOS Senior Develop"
    }

    // MARK: - Elements
    
    private var avatarLabel: UIImageView?
    private var titleLabel: UILabel?
    private var subtitleLabel: UILabel?
    
    // MARK: - Properties
    
    private var sut: GenericCell?
    private var viewModel: MokeGenericCellViewModel?
    
    // MARK: Override Methods
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    // MARK: - Tests Methods
    
    func test_snapshot() {
        makeViewModel(model: makeModel(title: Constants.title,
                                       subtitle: Constants.subtitle,
                                       imageUrl: Constants.imageUrl))
        makeSut()
        sut?.frame = CGRect(x: .zero, y: .zero, width: 320, height: 102)
        verifySnapshotView(delay: 3) {
            self.sut
        }
    }
    
    // MARK: - Private Methods
    
    private func makeSut() {
        sut = GenericCell.instantiate()
        guard let viewModel = viewModel else { return }
        sut?.setup(viewModel: viewModel)
        setupElements()
    }
    
    private func makeViewModel(model: GenericCellModel) {
        viewModel = MokeGenericCellViewModel(model: model)
    }
    
    private func makeModel(title: String? = nil, subtitle: String? = nil, imageUrl: String? = nil) -> GenericCellModel {
        return GenericCellModel(title: title, subtitle: subtitle, imageUrl: imageUrl)
    }
    
    private func setupElements() {
        titleLabel = findElement(in: sut, andIdentifier: .titleLabel)
        subtitleLabel = findElement(in: sut, andIdentifier: .subtitleLabel)
        avatarLabel = findElement(in: sut, andIdentifier: .avatarView)
    }
}

private class MokeGenericCellViewModel: GenericCellViewModelProtocol {
   
    var title = Dynamic<String?>(nil)
    var subtitle = Dynamic<String?>(nil)
    var imageUrl = Dynamic<String?>(nil)
    
    required init(model: GenericCellModel?) {
        title.value = model?.title
        subtitle.value = model?.subtitle
        imageUrl.value = model?.imageUrl
    }
}
 
