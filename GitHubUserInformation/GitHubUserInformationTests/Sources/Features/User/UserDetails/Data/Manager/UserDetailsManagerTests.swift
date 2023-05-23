//
//  UserDetailsManagerTests.swift
//  GitHubUserInformationTests
//
//  Created by Andre Luis Campopiano on 23/05/23.
//

@testable import GitHubUserInformation
import XCTest

class UserDetailsManagerTests: BaseXCTest {
    
    // MARK: - Properties
    
    private var sut: UserDetailsManager?
    private var provider: ApiProviderMock?
    
    // MARK: - Override Methods
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        provider = nil
    }
    
    // MARK: - Tests Methods
    
    func test_fetch_user_details_with_success() {
        let expectetion = XCTestExpectation()
        makeSut(fileName: "user_details_success")
        sut?.fetchUser(userName: "andrecampopiano") { result in
            switch result {
            case .success(let model):
                self.assertUserDetails(model: model)
                expectetion.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectetion], timeout: 2)
    }
    
    // MARK: - Private Methods
    
    private func assertUserDetails(model: UserResponse) {
        XCTAssertNotNil(model)
        
        XCTAssertEqual(model.login, "andrecampopiano")
        XCTAssertEqual(model.id, 8277291)
        XCTAssertEqual(model.gravatarId, String())
        XCTAssertEqual(model.url, "https://api.github.com/users/andrecampopiano")
        XCTAssertEqual(model.htmlUrl, "https://github.com/andrecampopiano")
        XCTAssertEqual(model.followersUrl, "https://api.github.com/users/andrecampopiano/followers")
        XCTAssertEqual(model.followingUrl, "https://api.github.com/users/andrecampopiano/following{/other_user}")
        XCTAssertEqual(model.gistsUrl, "https://api.github.com/users/andrecampopiano/gists{/gist_id}")
        XCTAssertEqual(model.starredUrl, "https://api.github.com/users/andrecampopiano/starred{/owner}{/repo}")
        XCTAssertEqual(model.subscriptionsUrl, "https://api.github.com/users/andrecampopiano/subscriptions")
        XCTAssertEqual(model.organizationsUrl, "https://api.github.com/users/andrecampopiano/orgs")
        XCTAssertEqual(model.reposUrl, "https://api.github.com/users/andrecampopiano/repos")
        XCTAssertEqual(model.eventsUrl, "https://api.github.com/users/andrecampopiano/events{/privacy}")
        XCTAssertEqual(model.receivedEventsUrl, "https://api.github.com/users/andrecampopiano/received_events")
        XCTAssertEqual(model.type, "User")
        if let siteAdmin = model.siteAdmin {
            XCTAssertFalse(siteAdmin)
        }
        XCTAssertEqual(model.name, "Andre Luis Campopiano")
        XCTAssertEqual(model.company, "BRQ")
        XCTAssertEqual(model.blog, "")
        XCTAssertEqual(model.location, "Itápolis")
        XCTAssertNil(model.email)
        XCTAssertNil(model.hireable)
        XCTAssertNil(model.bio)
        XCTAssertNil(model.twitterUsername)
        XCTAssertEqual(model.publicRepos, 30)
        XCTAssertEqual(model.publicGists, 0)
        XCTAssertEqual(model.followers, 14)
        XCTAssertEqual(model.following, 10)
        XCTAssertEqual(model.createdAt, "2014-07-26T19:49:20Z")
        XCTAssertEqual(model.updatedAt, "2023-05-20T15:46:16Z")
    }
    
    private func makeSut(fileName: String, responseStatus: HttpResponseStatus = .okay) {
        provider = ApiProviderMock(fileName: fileName, fileBundle: Bundle(for: GitHubUserInformationTests.self), responseStatus: responseStatus)
        sut = UserDetailsManager(provider: provider)
    }
}
