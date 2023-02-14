//
//  CharactersInteractorMock.swift
//  MarvelTests
//
//  Created by Òscar Muntal on 13/2/23.
//

import Combine
@testable import Marvel

class CharactersInteractorMock: CharactersInteractorContract {
    var fetchCharactersCalled = false
    var offset = ""
    
    func fetchCharacters(offset: String) -> AnyPublisher<MarvelResponse, MarvelError> {
        fetchCharactersCalled = true
        self.offset = offset
        return Empty().eraseToAnyPublisher()
    }
}
