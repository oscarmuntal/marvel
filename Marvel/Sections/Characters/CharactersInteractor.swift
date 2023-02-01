//
//  CharactersInteractor.swift
//  Marvel
//
//  Created by Òscar Muntal on 31/1/23.
//


class CharactersInteractor: CharactersInteractorContract {
    private var paginating = false
    public var isPaginating: Bool { paginating }
    private let charactersProvider: CharactersProviderContract
    
    init(charactersProvider: CharactersProviderContract = CharactersProvider()) {
        self.charactersProvider = charactersProvider
    }
    
    func fetchCharacters(offset: String, completion: @escaping (Result<[Character], MarvelError>) -> Void) {
        paginating = true
        charactersProvider.fetchCharacters(offset: offset) { (dataResult: Result<Response, MarvelError>) in
            switch dataResult {
            case .success(let result):
                completion(.success(result.data.results))
                
            case .failure(let error):
                completion(.failure(error))
            }
            self.paginating = false
        }
    }
}
