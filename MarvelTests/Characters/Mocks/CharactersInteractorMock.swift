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
    
    func fetchCharacters(offset: String) -> AnyPublisher<Response, MarvelError> {
        fetchCharactersCalled = true
        self.offset = offset
        return Empty().eraseToAnyPublisher()
    }
}


//class CharactersInteractorMock2: CharactersInteractorContract {
//    var fetchCharactersCalled = false
//    var offset = ""
//
//    func fetchCharacters(offset: String) -> AnyPublisher<Response, MarvelError> {
//        fetchCharactersCalled = true
//        self.offset = offset
//        let characters = [
//            defaultCharacter(id: 1011334, name: "3-D Man"),
//            defaultCharacter(id: 1017100, name: "A-Bomb (HAS)"),
//            defaultCharacter(id: 1009144, name: "A.I.M."),
//            defaultCharacter(id: 1009146, name: "Aaron Stack"),
//            defaultCharacter(id: 1009148, name: "Abomination (Emil Blonsky)")
//        ]
//        let data = CharactersData(offset: 0, limit: 0, total: characters.count, count: characters.count, results: characters)
//        let response = Response(copyright: "", attributionText: "", data: data)
//        return Result.success(response)
//            .publisher
//            .mapError { _ in MarvelError }
//            .eraseToAnyPublisher()
//    }
//}
