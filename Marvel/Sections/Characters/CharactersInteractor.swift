//
//  CharactersInteractor.swift
//  Marvel
//
//  Created by Òscar Muntal on 31/1/23.
//

import Combine

class CharactersInteractor: CharactersInteractorContract {
    public var isPaginating: Bool { paginating }
    private var paginating = false
    private let charactersProvider: CharactersProviderContract
    
    init(charactersProvider: CharactersProviderContract = CharactersProvider()) {
        self.charactersProvider = charactersProvider
    }
    
    func fetchCharacters(offset: String) -> AnyPublisher<Response, MarvelError> {
        return charactersProvider.fetchCharacters(offset: offset)
    }
    
    public func stopPaginating() {
        paginating = false
    }
    public func startPaginating() {
        paginating = true
    }
    
}
