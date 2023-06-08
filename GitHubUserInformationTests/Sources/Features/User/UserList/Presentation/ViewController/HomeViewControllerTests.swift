//
//  HomeViewControllerTests.swift
//  GitHubUserInformationTests
//
//  Created by Andre Luis Campopiano on 21/05/23.
//

import CoreSwift
@testable import GitHubUserInformation
import XCTest

class HomeViewControllerTests: BaseXCTest, Elements {
    
    typealias ElementsId = HomeViewControllerIdentifiers
    
    // MARK: - Elements
    
    private var tableView: UITableView?
    
    // MARK: - Properties
    
    private var sut: HomeViewController?
    private var viewModel: HomeViewModelProtocol?
    
    // MARK: - Override Methods
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        viewModel = nil
    }
    
    // MARK: - Tests Methods
    
    func test_snapshot_with_loading_view() {
        makeSut()
        guard let sut = sut else { return }
        viewModel?.status.value = .loading
        verifySnapshotView(delay: 2) {
            sut.view
        }
    }
    
    func test_snapshot_with_success() {
        makeSut(fileName: "user_list_success")
        guard let sut = sut else { return }
        verifySnapshotView(delay: 2) {
            sut.view
        }
    }
    
    func test_snapshot_with_success_and_one_user_in_list() {
        makeSut(fileName: "user_list_success_with_one_user")
        guard let sut = sut else { return }
        verifySnapshotView(delay: 2) {
            sut.view
        }
    }
    
    func test_snapshot_with_success_and_three_user_in_list() {
        makeSut(fileName: "user_list_success_with_three_user")
        guard let sut = sut else { return }
        verifySnapshotView(delay: 2) {
            sut.view
        }
    }
    
    func test_snapshot_with_error() {
        makeSut()
        guard let sut = sut else { return }
        viewModel?.status.value = .error
        verifySnapshotView(delay: 2) {
            sut.view
        }
    }
    
    // MARK: - Private Methods
    
    private func makeSut(fileName: String? = nil) {
        viewModel = setupViewModel(fileName: fileName)
        guard let viewModel = viewModel else { return }
        sut = HomeViewController.instantiate(viewModel: viewModel)
        sut?.viewDidLoad()
        addControllerToWindow(sut ?? UIViewController())
    }
    
    private func setupViewModel(fileName: String? = nil) -> HomeViewModelProtocol {
        return MockHomeViewModel(fileName: fileName)
    }
}

private class MockHomeViewModel: HomeViewModelProtocol {
    var model: [UserResponse]?
    
    var status = Dynamic<StatusApi?>(nil)
    
    private var fileName: String?
    
    required init(fileName: String? = nil) {
        self.fileName = fileName
    }
    
    func fetchUserList() {
        guard let fileName = fileName else { return self.status.value = .error }
        let file = FileRepresentation(withFileName: fileName, fileExtension: .json, fileBundle: .getBundleVirtualTechSupport)
        guard let data = file.data else { return }
        self.model = try? JSONDecoder().decode([UserResponse].self, from: data)
        self.status.value = .loaded
    }
}
