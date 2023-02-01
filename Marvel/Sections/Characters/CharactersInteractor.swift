//
//  CharactersInteractor.swift
//  Marvel
//
//  Created by Òscar Muntal on 31/1/23.
//

import Combine

class CharactersInteractor: CharactersInteractorContract {
    private var paginating = false
    public var isPaginating: Bool { paginating }
    private let charactersProvider: CharactersProviderContract
    
    init(charactersProvider: CharactersProviderContract = CharactersProvider()) {
        self.charactersProvider = charactersProvider
    }
    
    func fetchCharacters(offset: String) -> Future<[Character], MarvelError> {
        paginating = true
        return Future { promise in
            self.charactersProvider.fetchCharacters(offset: offset) { (dataResult: Result<Response, MarvelError>) in
                switch dataResult {
                case .success(let result):
                    promise(.success(result.data.results))
                case .failure(let error):
                    promise(.failure(error))
                }
                self.paginating = false
            }
        }
    }
}
