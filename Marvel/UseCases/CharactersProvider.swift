//
//  CharactersProvider.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//

import Foundation

protocol CharactersProviderContract {
    func fetchCharacters(offset: String, completion: @escaping (Result<Response, MarvelError>) -> Void)
}

class CharactersProvider: CharactersProviderContract {
    private let apiRouter: ApiRouting
    
    init(apiRouter: ApiRouting = ApiRouter.shared) {
        self.apiRouter = apiRouter
    }
    
    func fetchCharacters(offset: String, completion: @escaping (Result<Response, MarvelError>) -> Void) {
        apiRouter.requestDecodable(MarvelApi.characters(offset: offset)) { (dataResult: Result<Response, MarvelError>) in
            switch dataResult {
            case .success(let result):
                completion(.success(result))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
