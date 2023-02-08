//
//  CharactersPresenter.swift
//  Marvel
//
//  Created by Òscar Muntal on 31/1/23.
//

import Foundation
import Combine

class CharactersPresenter {
    private let wireframe: CharactersWireframe?
    private let interactor: CharactersInteractorContract?
    private let router: CharactersRouterContract?
    
    var currentPage = 0
    var offset: String {
        String(currentPage*20)
    }
    var cancellables: Set<AnyCancellable> = []
    
    init(wireframe: CharactersWireframe, interactor: CharactersInteractorContract, router: CharactersRouterContract) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.router = router
    }
    
    internal var view: CharactersViewContract? {
        didSet {
            loadCharacters()
        }
    }
    
    internal var characters = [Character]() {
        didSet {
            view?.reload()
        }
    }
}
    
extension CharactersPresenter: CharactersPresenterContract {
    func numCharacters() -> Int {
        characters.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CharacterCellViewModel {
        characters[indexPath.row].toCellViewModel
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let character = characters[indexPath.row]
        router?.didSelect(item: character.id)
    }
    
    func didScroll() {
        loadCharacters()
    }
    
    func isPaginating() -> Bool {
        interactor?.isPaginating ?? false
    }
}

private extension CharactersPresenter {
    func loadCharacters() {
        guard let view = view, let interactor = interactor else { return }
        view.configureTableFooter()
        interactor.startPaginating()
        interactor.fetchCharacters(offset: offset)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                interactor.stopPaginating()
                switch completion {
                case .finished:
                    print("Finished! - Publisher stopped observing")
                case .failure(let error):
                    print("Failure! with \(error)")
                    self?.view?.showErrorAlert(withTitle: error.title, withMessage: error.message)
                }
            }, receiveValue: { [weak self] response in
                self?.characters.append(contentsOf: response.data.results)
                self?.currentPage += 1
            }).store(in: &cancellables)
    }
}
