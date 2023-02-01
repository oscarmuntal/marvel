//
//  CharacterDetailInteractor.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//

import Foundation

class CharacterDetailInteractor: CharacterDetailInteractorContract {
    let characterDetailProvider: CharacterDetailProviderContract
    
    init(characterDetailProvider: CharacterDetailProviderContract = CharacterDetailProvider()) {
        self.characterDetailProvider = characterDetailProvider
    }
    
    func fetchCharacterDetail(id: Int, completion: @escaping (Result<Response, MarvelError>) -> Void) {
        characterDetailProvider.fetchCharacterById(id) { (dataResult: Result<Response, MarvelError>) in
            switch dataResult {
            case .success(let result):
                completion(.success(result))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
