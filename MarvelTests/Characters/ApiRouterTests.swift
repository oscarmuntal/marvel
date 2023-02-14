//
//  ApiRouterTests.swift
//  MarvelTests
//
//  Created by Òscar Muntal on 13/2/23.
//

import XCTest
import Alamofire
import Combine
@testable import Marvel


class ApiRouterTests: XCTestCase {
    private var apiRouter: ApiRouter!
    private var networkManager: NetworkManagerMock!
    private var networkManagerWithError: NetworkManagerMockWithError!
    
    override func setUp() {
        super.setUp()
//        networkManager = NetworkManagerMock()
//        apiRouter = ApiRouter(networkManager: networkManager)
    }
    
    func testRequestDecodableSuccess() {
        // given
        networkManager = NetworkManagerMock()
        apiRouter = ApiRouter(networkManager: networkManager)
        let expectedResult = "testResult".data(using: .utf8)!
        networkManager.mockedData = expectedResult
        networkManager.mockedResult = .success("testResult")
        
        // when
        let expectation = self.expectation(description: "completion called")
        apiRouter.requestDecodable(MarvelApi.characters(offset: "0"), { (result: Result<String, MarvelError>) in
            // then
            switch result {
            case .success(let data):
                XCTAssertEqual(data, expectedResult.string)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testRequestDecodableFailure() {
        // given
        networkManagerWithError = NetworkManagerMockWithError(error: NetworkManagerError.missingApiBaseUrl)
        apiRouter = ApiRouter(networkManager: networkManagerWithError)
        
        // when
        let expectation = self.expectation(description: "Request should fail")
        apiRouter.requestDecodable(MarvelApi.characters(offset: "0")) { (result: Result<String, MarvelError>) in
            // then
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, MarvelError.other)
                expectation.fulfill()
            case .success:
                XCTFail("The request should fail with error")
            }
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("The request should not timeout. Error: \(error)")
            }
        }
    }
}

extension Data {
    var string: String {
        return String(data: self, encoding: .utf8) ?? ""
    }
}

class NetworkManagerMock: NetworkManager {
    var mockedResult: Result<String, Error>?
    var mockedStatusCode: Int?
    var mockedData: Data?
    
    func request<T: Decodable>(_ urlRequest: URLRequest,
                               onSuccess: @escaping (T, Int?) -> Void,
                               onError: @escaping (Error, Int?, Data?) -> Void) {
        if let result = mockedResult as? Result<T, Error> {
            switch result {
            case .success(let response):
                onSuccess(response , mockedStatusCode)
            case .failure(let error):
                onError(error, mockedStatusCode, mockedData)
            }
        }
    }
}

class NetworkManagerMockWithError: NetworkManager {
    let error: Error
    
    init(error: Error) {
        self.error = error
    }
    
    func request<T: Decodable>(_ urlRequest: URLRequest,
                               onSuccess: @escaping (T, Int?) -> Void,
                               onError: @escaping (Error, Int?, Data?) -> Void) {
        onError(error, nil, nil)
    }
}

