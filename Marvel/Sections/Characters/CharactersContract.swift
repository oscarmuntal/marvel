//
//  CharactersContract.swift
//  Marvel
//
//  Created by Òscar Muntal on 31/1/23.
//

import Foundation
import Alamofire

protocol CharactersWireframe {}

protocol CharactersViewContract: ReloadAwareView {
    func configureTableFooter()
    func resetTableFooter()
}

protocol CharactersPresenterContract {
    var view: CharactersViewContract? { get set }
    func numCharacters() -> Int
    func cellViewModel(at indexPath: IndexPath) -> CharacterCellViewModel
    func isPaginating() -> Bool
    func didScroll()
}

protocol CharactersInteractorContract {
    func fetchCharacters(offset: String, completion: @escaping (Result<[Character], MarvelError>) -> Void)
    var isPaginating: Bool { get }
}
