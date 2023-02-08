//
//  CharacterDetailInteractor.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//

import Combine

class CharacterDetailInteractor: CharacterDetailInteractorContract {
    let characterDetailProvider: CharacterDetailProviderContract
    
    init(characterDetailProvider: CharacterDetailProviderContract = CharacterDetailProvider()) {
        self.characterDetailProvider = characterDetailProvider
    }
    
    func fetchCharacterDetail(id: Int) -> AnyPublisher<Response, MarvelError> {
        characterDetailProvider.fetchCharacterById(id)
    }
}
