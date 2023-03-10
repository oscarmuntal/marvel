//
//  CharactersProvider.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//

import Foundation
import Combine

protocol CharactersProviderContract {
    func fetchCharacters(offset: String) -> AnyPublisher<MarvelResponse, MarvelError>
}

class CharactersProvider: CharactersProviderContract {
    private let apiRouter: ApiRouting
    
    init(apiRouter: ApiRouting = ApiRouter.shared) {
        self.apiRouter = apiRouter
    }
    
    func fetchCharacters(offset: String) -> AnyPublisher<MarvelResponse, MarvelError> {
        apiRouter.requestDecodablePublisher(MarvelApi.characters(offset: offset))
    }
}
