//
//  CharactersInteractor.swift
//  Marvel
//
//  Created by Òscar Muntal on 31/1/23.
//

import Combine

class CharactersInteractor: CharactersInteractorContract {
    private let charactersProvider: CharactersProviderContract
    
    init(charactersProvider: CharactersProviderContract = CharactersProvider()) {
        self.charactersProvider = charactersProvider
    }
    
    func fetchCharacters(offset: String) -> AnyPublisher<Response, MarvelError> {
        charactersProvider.fetchCharacters(offset: offset)
    }
}
