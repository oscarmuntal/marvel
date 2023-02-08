//
//  CharactersContract.swift
//  Marvel
//
//  Created by Òscar Muntal on 31/1/23.
//

import Alamofire
import Combine

protocol MarvelCharactersViewContract: UIViewController {
    func errorAlertAction() -> UIAlertAction
    func showErrorAlert(withTitle title: String, withMessage message: String)
}

extension MarvelCharactersViewContract {
    func showErrorAlert(withTitle title: String, withMessage message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(self.errorAlertAction())
            self.present(alertController, animated: true)
        }
    }
}

protocol CharactersWireframe: CharacterDetailOpener {}

protocol CharactersViewContract: ReloadAwareView, MarvelCharactersViewContract {
    func configureTableFooter()
    func resetTableFooter()
    func showErrorAlert(withTitle title: String, withMessage message: String)
}

protocol CharactersPresenterContract {
    var view: CharactersViewContract? { get set }
    func numCharacters() -> Int
    func cellViewModel(at indexPath: IndexPath) -> CharacterCellViewModel
    func didSelectItem(at indexPath: IndexPath)
    func isPaginating() -> Bool
    func didScroll()
}

protocol CharactersInteractorContract {
    func fetchCharacters(offset: String) -> AnyPublisher<Response, MarvelError>
    func startPaginating()
    func stopPaginating()
    var isPaginating: Bool { get }
}
