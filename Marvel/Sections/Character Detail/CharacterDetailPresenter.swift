//
//  CharacterDetailPresenter.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//

import Foundation
import Alamofire

class CharacterDetailPresenter: CharacterDetailPresenterContract {
    private let wireframe: CharacterDetailWireframe?
    private let interactor: CharacterDetailInteractorContract?
    
    init(wireframe: CharacterDetailWireframe, interactor: CharacterDetailInteractorContract) {
        self.wireframe = wireframe
        self.interactor = interactor
    }
    
    var view: CharacterDetailViewContract? {
        didSet {
            setup()
        }
    }
}

private extension CharacterDetailPresenter {
    func setup() {
        // access Interactor and fetch the character detail
    }
}
