//
//  CharactersContract.swift
//  Marvel
//
//  Created by Òscar Muntal on 31/1/23.
//

import Alamofire
import Combine

protocol MarvelCharactersViewContract: UIViewController, AlertOpener {
    func errorAlertAction() -> UIAlertAction
    func showErrorAlert(withTitle title: String, withMessage message: String)
}

extension MarvelCharactersViewContract {
    func showErrorAlert(withTitle title: String, withMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(self.errorAlertAction())
        openAlert(alertController, animated: true)
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
    func didScroll()
    func isPaginating() -> Bool
}

protocol CharactersInteractorContract {
    func fetchCharacters(offset: String) -> AnyPublisher<Response, MarvelError>
}
