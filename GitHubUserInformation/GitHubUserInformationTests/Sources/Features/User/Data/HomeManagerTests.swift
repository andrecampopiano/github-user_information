//
//  HomeManagerTests.swift
//  GitHubUserInformationTests
//
//  Created by Andre Luis Campopiano on 22/05/23.
//

@testable import GitHubUserInformation
import XCTest

class HomeManagerTests: BaseXCTest {
    
    private var sut: HomeManager?
    private var provider: ApiProviderMock?
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        provider = nil
    }
    
    func test_fetch_user_list_with_success() {
        let expectation = XCTestExpectation()
        makeSut(filenName: "user_list_success_with_three_user")
        sut?.fetchUserList { result in
            switch result {
            case .success(let model):
                self.assertUserList(model: model)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 2)
    }
    
    func test_fetch_user_list_with_parse_error() {
        let expectation = XCTestExpectation()
        makeSut(filenName: "user_list_parse_error", responseStatus: .okay)
        sut?.fetchUserList { result in
            switch result {
            case .success(let model):
                self.assertUserList(model: model)
                XCTFail("Error")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2)
    }
    
    // MARK: - Private Methods
    
    private func assertUserList(model: [UserResponse]) {
        XCTAssertEqual(model.count, 3)
        assertUserList(first: model[0])
        assertUserList(secound: model[1])
        assertUserList(third: model[2])
    }
    
    private func assertUserList(first: UserResponse) {
        XCTAssertEqual(first.login, "mojombo")
        XCTAssertEqual(first.id, 1)
        XCTAssertEqual(first.gravatarId, String())
        XCTAssertEqual(first.url, "https://api.github.com/users/mojombo")
        XCTAssertEqual(first.htmlUrl, "https://github.com/mojombo")
        XCTAssertEqual(first.followersUrl, "https://api.github.com/users/mojombo/followers")
        XCTAssertEqual(first.followingUrl, "https://api.github.com/users/mojombo/following{/other_user}")
        XCTAssertEqual(first.gistsUrl, "https://api.github.com/users/mojombo/gists{/gist_id}")
        XCTAssertEqual(first.starredUrl, "https://api.github.com/users/mojombo/starred{/owner}{/repo}")
        XCTAssertEqual(first.subscriptionsUrl, "https://api.github.com/users/mojombo/subscriptions")
        XCTAssertEqual(first.organizationsUrl, "https://api.github.com/users/mojombo/orgs")
        XCTAssertEqual(first.reposUrl, "https://api.github.com/users/mojombo/repos")
        XCTAssertEqual(first.eventsUrl, "https://api.github.com/users/mojombo/events{/privacy}")
        XCTAssertEqual(first.receivedEventsUrl, "https://api.github.com/users/mojombo/received_events")
        XCTAssertEqual(first.type, "User")
        if let siteAdmin = first.siteAdmin {
            XCTAssertFalse(siteAdmin)
        }
    }
    
    private func assertUserList(secound: UserResponse) {
        XCTAssertEqual(secound.login, "defunkt")
        XCTAssertEqual(secound.id, 2)
        XCTAssertEqual(secound.gravatarId, String())
        XCTAssertEqual(secound.url, "https://api.github.com/users/defunkt")
        XCTAssertEqual(secound.htmlUrl, "https://github.com/defunkt")
        XCTAssertEqual(secound.followersUrl, "https://api.github.com/users/defunkt/followers")
        XCTAssertEqual(secound.followingUrl, "https://api.github.com/users/defunkt/following{/other_user}")
        XCTAssertEqual(secound.gistsUrl, "https://api.github.com/users/defunkt/gists{/gist_id}")
        XCTAssertEqual(secound.starredUrl, "https://api.github.com/users/defunkt/starred{/owner}{/repo}")
        XCTAssertEqual(secound.subscriptionsUrl, "https://api.github.com/users/defunkt/subscriptions")
        XCTAssertEqual(secound.organizationsUrl, "https://api.github.com/users/defunkt/orgs")
        XCTAssertEqual(secound.reposUrl, "https://api.github.com/users/defunkt/repos")
        XCTAssertEqual(secound.eventsUrl, "https://api.github.com/users/defunkt/events{/privacy}")
        XCTAssertEqual(secound.receivedEventsUrl, "https://api.github.com/users/defunkt/received_events")
        XCTAssertEqual(secound.type, "User")
        if let siteAdmin = secound.siteAdmin {
            XCTAssertFalse(siteAdmin)
        }
    }
    
    private func assertUserList(third: UserResponse) {
        XCTAssertEqual(third.login, "pjhyett")
        XCTAssertEqual(third.id, 3)
        XCTAssertEqual(third.gravatarId, String())
        XCTAssertEqual(third.url, "https://api.github.com/users/pjhyett")
        XCTAssertEqual(third.htmlUrl, "https://github.com/pjhyett")
        XCTAssertEqual(third.followersUrl, "https://api.github.com/users/pjhyett/followers")
        XCTAssertEqual(third.followingUrl, "https://api.github.com/users/pjhyett/following{/other_user}")
        XCTAssertEqual(third.gistsUrl, "https://api.github.com/users/pjhyett/gists{/gist_id}")
        XCTAssertEqual(third.starredUrl, "https://api.github.com/users/pjhyett/starred{/owner}{/repo}")
        XCTAssertEqual(third.subscriptionsUrl, "https://api.github.com/users/pjhyett/subscriptions")
        XCTAssertEqual(third.organizationsUrl, "https://api.github.com/users/pjhyett/orgs")
        XCTAssertEqual(third.reposUrl, "https://api.github.com/users/pjhyett/repos")
        XCTAssertEqual(third.eventsUrl, "https://api.github.com/users/pjhyett/events{/privacy}")
        XCTAssertEqual(third.receivedEventsUrl, "https://api.github.com/users/pjhyett/received_events")
        XCTAssertEqual(third.type, "User")
        if let siteAdmin = third.siteAdmin {
            XCTAssertFalse(siteAdmin)
        }
    }
    
    private func makeSut(filenName: String, responseStatus: HttpResponseStatus = .okay) {
        provider = ApiProviderMock(fileName: filenName, fileBundle: Bundle(for: GitHubUserInformationTests.self), responseStatus: responseStatus)
        sut = HomeManager(provider: provider)
    }
}
