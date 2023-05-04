//
//  GitHubListAppTests.swift
//  GitHubListAppTests
//
//  Created by petrut alexandra on 27.04.2023.
//

import XCTest
import Combine

final class GitHubListAppTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()

    func testFetchTrendingRepositories() {
        let apiService = APIService()
        let expectation = XCTestExpectation(description: "Fetch trending repositories")
        
        apiService.fetchTrendingRepositories(from: "2022-01-01")
            .sink { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Expected successful result, but got error: \(error)")
                case .finished:
                    expectation.fulfill()
                }
            } receiveValue: { repositories in
                XCTAssertEqual(repositories.count, 10)
                // Add more assertions as needed
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchTrendingRepositoriesWithInvalidDate() {
         let apiService = APIService()
         let expectation = XCTestExpectation(description: "Fetch trending repositories with invalid date")

         apiService.fetchTrendingRepositories(from: "invalid-date")
             .sink { completion in
                 switch completion {
                 case .failure(let error):
                     XCTAssertTrue(error is URLError)
                 case .finished:
                     XCTFail("Expected error, but got successful result")
                 }
                 expectation.fulfill()
             } receiveValue: { _ in
                 XCTFail("Expected error, but got successful result")
             }
             .store(in: &cancellables)

         wait(for: [expectation], timeout: 5.0)
     }

}



class MockURLProtocol: URLProtocol {
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        // Simulate a network error by returning an error response
        let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        self.client?.urlProtocol(self, didFailWithError: error)
    }
    
    override func stopLoading() {
        // Do nothing
    }
    
}
