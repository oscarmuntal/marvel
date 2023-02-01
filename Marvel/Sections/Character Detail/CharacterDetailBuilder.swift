//
//  CharacterDetailBuilder.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//

import Foundation
import UIKit

protocol CharacterDetailBuilderContract: Builder {
    var wireframe: CharacterDetailWireframe { get }
    func buildViewController() -> UIViewController
    func buildPresenter() -> CharacterDetailPresenterContract
    func buildInteractor() -> CharacterDetailInteractorContract
}

extension CharacterDetailBuilderContract {
    func buildPresenter() -> CharacterDetailPresenterContract {
        CharacterDetailPresenter(wireframe: wireframe, interactor: buildInteractor())
    }
    
    func buildInteractor() -> CharacterDetailInteractorContract {
        CharacterDetailInteractor()
    }
}

class CharacterDetailBuilder: CharacterDetailBuilderContract {
    internal let wireframe: CharacterDetailWireframe
    
    init(wireframe: CharacterDetailWireframe) {
        self.wireframe = wireframe
    }
    
    func buildViewController() -> UIViewController {
        let vc = CharacterDetailView.createFromStoryboard()
        vc.presenter = buildPresenter()
        return vc
    }
}


