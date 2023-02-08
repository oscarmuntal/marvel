//
//  CharacterDetailProvider.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//

import Foundation
import Combine

protocol CharacterDetailProviderContract {
    func fetchCharacterById(_ id: Int) -> AnyPublisher<Response, MarvelError>
}

class CharacterDetailProvider: CharacterDetailProviderContract {
    private let apiRouter: ApiRouting
    
    init(apiRouter: ApiRouting = ApiRouter.shared) {
        self.apiRouter = apiRouter
    }
    
    func fetchCharacterById(_ id: Int) -> AnyPublisher<Response, MarvelError> {
        apiRouter.requestDecodablePublisher(MarvelApi.characterDetail(id: id))
    }
}
