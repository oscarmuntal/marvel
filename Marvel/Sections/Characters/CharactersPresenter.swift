//
//  CharactersPresenter.swift
//  Marvel
//
//  Created by Òscar Muntal on 31/1/23.
//

import Foundation

class CharactersPresenter: CharactersPresenterContract {
    private let wireframe: CharactersWireframe?
    private let interactor: CharactersInteractorContract?
    
    init(wireframe: CharactersWireframe, interactor: CharactersInteractorContract) {
        self.wireframe = wireframe
        self.interactor = interactor
    }
    
    var view: CharactersViewContract? {
        didSet {
            // Crida a l'interactor perque descarregui el llistat de characters
        }
    }
}
