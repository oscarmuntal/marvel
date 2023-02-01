//
//  CharacterDetailContract.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//

import Foundation
import Alamofire

protocol CharacterDetailWireframe {}

protocol CharacterDetailViewContract {
    func configure(with character: Character)
    func startActivityIndicator()
    func stopActivityIndicator()
}

protocol CharacterDetailPresenterContract {
    var view: CharacterDetailViewContract? { get set }
    var characterId: Int? { get set }
}

protocol CharacterDetailInteractorContract {
    func fetchCharacterDetail(id: Int, completion: @escaping (Result<Response, MarvelError>) -> Void)
}
