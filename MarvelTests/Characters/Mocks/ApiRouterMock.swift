//
//  ApiRouterMock.swift
//  MarvelTests
//
//  Created by Òscar Muntal on 13/2/23.
//

import Combine
@testable import Marvel

class ApiRouterMock: ApiRouting {
    var requestDecodableCalled = false
    var requestDecodablePublisherCalled = false
    var completionResult: Result<MarvelResponse, MarvelError>?
    
    func requestDecodable<T: Decodable>(_ apiCall: ApiCall, _ completion: @escaping (Result<T, MarvelError>) -> Void) {
        requestDecodableCalled = true
        if let result = completionResult as? Result<T, MarvelError> {
            completion(result)
        }
    }
    
    func requestDecodablePublisher<T: Decodable>(_ apiCall: ApiCall) -> AnyPublisher<T, MarvelError> {
        requestDecodablePublisherCalled = true
        return Deferred {
            Future { promise in
                if let result = self.completionResult as? Result<T, MarvelError> {
                    promise(result)
                }
            }
        }.eraseToAnyPublisher()
    }
}
