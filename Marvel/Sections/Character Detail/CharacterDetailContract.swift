//
//  CharacterDetailContract.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//

import Alamofire

protocol CharacterDetailWireframe {}

protocol CharacterDetailViewContract: MarvelCharactersViewContract {
    func configure(with character: Character)
    func startActivityIndicator()
    func stopActivityIndicator()
    func showErrorAlert(withTitle title: String, withMessage message: String)
}

protocol CharacterDetailPresenterContract {
    var view: CharacterDetailViewContract? { get set }
    var characterId: Int? { get set }
}

protocol CharacterDetailInteractorContract {
    func fetchCharacterDetail(id: Int, completion: @escaping (Result<Response, MarvelError>) -> Void)
}
