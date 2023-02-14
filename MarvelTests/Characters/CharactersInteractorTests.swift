//
//  CharactersInteractorTests.swift
//  MarvelTests
//
//  Created by Òscar Muntal on 13/2/23.
//

import XCTest
import Combine
@testable import Marvel

class CharactersInteractorTests: XCTestCase {
    var interactor: CharactersInteractor!
    var charactersProvider: CharactersProviderMock!
    
    override func setUp() {
        super.setUp()
        charactersProvider = CharactersProviderMock()
        interactor = CharactersInteractor(charactersProvider: charactersProvider)
    }

    override func tearDown() {
        interactor = nil
        charactersProvider = nil
        super.tearDown()
    }

    func testFetchCharacters() {
        // given
        let expectedResult = Result<MarvelResponse, MarvelError>.success(defaultResponse())
        charactersProvider.result = expectedResult
        
        // when
        let offset = "0"
        let cancelable = interactor.fetchCharacters(offset: offset)
            .sink(receiveCompletion: { completion in
                // then
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Test failed with error: \(error)")
                }
            }, receiveValue: { response in
                // then
                if case .success(let responseValue) = expectedResult {
                    XCTAssertEqual(response.copyright, responseValue.copyright)
                    XCTAssertEqual(response.attributionText, responseValue.attributionText)
                    XCTAssertEqual(response.data.count, responseValue.data.count)
                } else {
                    XCTFail("Expected Result to be success, got failure")
                }
            })
        XCTAssertNotNil(cancelable)
    }
}

