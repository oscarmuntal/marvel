//
//  CharactersProvider.swift
//  MarvelTests
//
//  Created by Òscar Muntal on 13/2/23.
//

import XCTest
import Combine
@testable import Marvel

class CharactersProviderTest: XCTestCase {
    var apiRouter: ApiRouterMock!
    var charactersProvider: CharactersProvider!
    
    override func setUp() {
        super.setUp()
        apiRouter = ApiRouterMock()
        charactersProvider = CharactersProvider(apiRouter: apiRouter)
    }
    
    func testFetchCharactersSuccess() {
        // given
        let expectedResult = Result<MarvelResponse, MarvelError>.success(defaultResponse())
        apiRouter.completionResult = expectedResult
        
        // when
        let offset = "0"
        let cancellable = charactersProvider.fetchCharacters(offset: offset)
            .sink(receiveCompletion: { completion in
                // then
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("fetchCharacters failed with error: \(error)")
                }
            }, receiveValue: { response in
                // then
                if case .success(let responseValue) = expectedResult {
                    XCTAssertEqual(response.data.count, responseValue.data.count)
                } else {
                    XCTFail("Expected Result to be success, got failure")
                }
            })
        
        XCTAssertTrue(apiRouter.requestDecodablePublisherCalled)
        cancellable.cancel()
    }
    
    func testFetchCharactersFailure() {
        // given
        let expectedResult = Result<MarvelResponse, MarvelError>.failure(.other)
        apiRouter.completionResult = expectedResult
        
        // when
        let offset = "0"
        let cancellable = charactersProvider.fetchCharacters(offset: offset)
            .sink(receiveCompletion: { completion in
                // then
                switch completion {
                case .finished:
                    XCTFail("fetchCharacters succeeded, expected failure")
                case .failure(let error):
                    XCTAssertEqual(error, MarvelError.other)
                }
            }, receiveValue: { response in
                // then
                XCTFail("fetchCharacters succeeded, expected failure")
            })
        
        XCTAssertTrue(apiRouter.requestDecodablePublisherCalled)
        cancellable.cancel()
    }
    
}


private class NetworkServerFailure: NetworkManager {
    func request<Response: Decodable>(_ urlRequest: URLRequest,
        onSuccess: @escaping (Response, Int?) -> Void,
        onError: @escaping (Error, Int?, Data?) -> Void) {
        onError(NetworkManagerError.missingApiBaseUrl, nil, nil)
    }
}
