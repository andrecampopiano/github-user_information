//
//  HomeViewModelTests.swift
//  GitHubUserInformationTests
//
//  Created by Andre Luis Campopiano on 22/05/23.
//

@testable import GitHubUserInformation
import XCTest

class HomeViewModelTests: BaseXCTest {
    
    // MARK: - Properties
    
    private var sut: HomeViewModel?
    
    // MARK: - Override Methods
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    // MARK: - Tests Methods
    
    func test_retorn_succces_user_list() {
        let expectation = XCTestExpectation(description: "testing fetch with success")
        makeSut(manager: HomeManagerSuccessUserListMock())
        sut?.status.bind(skip: true) { status in
            if status == .loaded {
                XCTAssertNotNil(self.sut?.model)
                XCTAssertEqual(self.sut?.model?.count, 3)
                XCTAssertEqual(self.sut?.status.value, .loaded)
                expectation.fulfill()
            }
        }
        
        sut?.fetchUserList()
        wait(for: [expectation], timeout: 20)
    }
    
    func test_return_error_user_list() {
        let expectation = XCTestExpectation(description: "testing fetch with error parse")
        makeSut(manager: HomeManagerErrorUserListMock())
        sut?.status.bind(skip: true) { status in
            if status == .error {
                XCTAssertNil(self.sut?.model)
                XCTAssertEqual(self.sut?.status.value, .error)
                expectation.fulfill()
            }
        }
        sut?.fetchUserList()
        wait(for: [expectation], timeout: 20)
    }
    
    // MARK: - Private Methods
    
    private func makeSut(manager: HomeManagerProtocol?) {
        sut = HomeViewModel(manager: manager)
    }
}

private class HomeManagerSuccessUserListMock: HomeManagerProtocol {
    
    private let userList = [UserResponse(login: "loginMock01"),
                            UserResponse(login: "loginMock02"),
                            UserResponse(login: "loginMock03")]
    
    func fetchUserList(completion: @escaping UserListGetCompletion) {
        completion(.success(userList))
    }
}

private class HomeManagerErrorUserListMock: HomeManagerProtocol {
    func fetchUserList(completion: @escaping UserListGetCompletion) {
        completion(.failure(BaseError.parse("Error Parse")))
    }
}
