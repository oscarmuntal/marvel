//
//  CharacterDetailPresenter.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//

import Alamofire

class CharacterDetailPresenter: CharacterDetailPresenterContract {
    private let wireframe: CharacterDetailWireframe?
    private let interactor: CharacterDetailInteractorContract?
    public var characterId: Int?
    
    init(wireframe: CharacterDetailWireframe, interactor: CharacterDetailInteractorContract, characterId: Int?) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.characterId = characterId
    }
    
    var view: CharacterDetailViewContract? {
        didSet {
            setup()
        }
    }
}

private extension CharacterDetailPresenter {
    func setup() {
        view?.startActivityIndicator()
        guard let id = characterId else { return }
        interactor?.fetchCharacterDetail(id: id, completion: { [weak self] result in
            self?.view?.stopActivityIndicator()
            switch result {
            case .success(let result):
                guard let character = result.data.results.first else { return }
                self?.view?.configure(with: character)

            case .failure(let error):
                self?.view?.showErrorAlert(withTitle: error.title, withMessage: error.message)
            }
        })
    }
}
