//
//  CharactersPresenter.swift
//  Marvel
//
//  Created by Òscar Muntal on 31/1/23.
//

import Foundation
class CharactersPresenter {
    private let wireframe: CharactersWireframe?
    private let interactor: CharactersInteractorContract?
    private let router: CharactersRouterContract?
    
    var currentPage = 0
    var offset: String {
        String(currentPage*20)
    }
    
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
    
    func didScroll() {
        loadCharacters()
    }
    
    func isPaginating() -> Bool {
        interactor?.isPaginating ?? false
    }
}

private extension CharactersPresenter {
    func loadCharacters() {
        view?.configureTableFooter()
        interactor?.fetchCharacters(offset: offset) { [weak self] result in
            self?.view?.resetTableFooter()
            switch result {
            case .success(let results):
                self?.characters.append(contentsOf: results)
                
            case .failure(let error):
                // handle error
                print(error)
            }
            self?.currentPage += 1
        }
    }
}
