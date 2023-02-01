//
//  CharacterDetailBuilder.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//

import UIKit

protocol CharacterDetailBuilderContract: Builder {
    var wireframe: CharacterDetailWireframe { get }
    var characterId: Int? { get }
    func buildViewController() -> UIViewController
    func buildPresenter() -> CharacterDetailPresenterContract
    func buildInteractor() -> CharacterDetailInteractorContract
}

extension CharacterDetailBuilderContract {
    func buildPresenter() -> CharacterDetailPresenterContract {
        CharacterDetailPresenter(wireframe: wireframe, interactor: buildInteractor(), characterId: characterId)
    }
    
    func buildInteractor() -> CharacterDetailInteractorContract {
        CharacterDetailInteractor()
    }
}

class CharacterDetailBuilder: CharacterDetailBuilderContract {
    internal let wireframe: CharacterDetailWireframe
    internal let characterId: Int?
    
    init(wireframe: CharacterDetailWireframe, characterId: Int) {
        self.wireframe = wireframe
        self.characterId = characterId
    }
    
    func buildViewController() -> UIViewController {
        let vc = CharacterDetailView.createFromStoryboard()
        vc.presenter = buildPresenter()
        vc.presenter?.characterId = self.characterId
        return vc
    }
}
