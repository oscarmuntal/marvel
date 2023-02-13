//
//  CharactersProviderMock.swift
//  MarvelTests
//
//  Created by Òscar Muntal on 13/2/23.
//

import Combine
@testable import Marvel

class CharactersProviderMock: CharactersProviderContract {
    var result: Result<Response, MarvelError>!
    
    func fetchCharacters(offset: String) -> AnyPublisher<Response, MarvelError> {
        return Result.Publisher(result).eraseToAnyPublisher()
    }
}
