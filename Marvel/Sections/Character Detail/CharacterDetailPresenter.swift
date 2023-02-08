//
//  CharacterDetailPresenter.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//

import Alamofire
import Combine

class CharacterDetailPresenter: CharacterDetailPresenterContract {
    private let wireframe: CharacterDetailWireframe?
    private let interactor: CharacterDetailInteractorContract?
    public var characterId: Int?
    var cancellables: Set<AnyCancellable> = []
    
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
        interactor?.fetchCharacterDetail(id: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.view?.stopActivityIndicator()
                switch completion {
                case .failure(let error):
                    self?.view?.showErrorAlert(withTitle: error.title, withMessage: error.message)
                case .finished: break
                }
            }, receiveValue: { [weak self] response in
                guard let character = response.data.results.first else { return }
                self?.view?.configure(with: character)
            }).store(in: &cancellables)
    }
}
