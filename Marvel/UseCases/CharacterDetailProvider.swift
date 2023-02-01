//
//  CharacterDetailProvider.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//

import Foundation

protocol CharacterDetailProviderContract {
    func fetchCharacterById(_ id: Int, _ completion: @escaping (Result<Response, MarvelError>) -> Void)
}

class CharacterDetailProvider: CharacterDetailProviderContract {
    private let apiRouter: ApiRouting
    
    init(apiRouter: ApiRouting = ApiRouter.shared) {
        self.apiRouter = apiRouter
    }
    
    func fetchCharacterById(_ id: Int, _ completion: @escaping (Result<Response, MarvelError>) -> Void) {
        apiRouter.requestDecodable(MarvelApi.characterDetail(id: id)) { (dataResult: Result<Response, MarvelError>) in
            switch dataResult {
            case .success(let result):
                completion(.success(result))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

