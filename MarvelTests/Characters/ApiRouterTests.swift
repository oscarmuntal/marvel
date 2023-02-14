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
    
    override func setUp() {
        super.setUp()
        networkManager = NetworkManagerMock()
        apiRouter = ApiRouter(networkManager: networkManager)
    }
    
    func testRequestDecodableSuccess() {
        // given
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
