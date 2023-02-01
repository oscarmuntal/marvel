//
//  CharactersBuilder.swift
//  Marvel
//
//  Created by Òscar Muntal on 31/1/23.
//

import UIKit

protocol CharactersBuilderContract: Builder {
    var wireframe: CharactersWireframe { get }
    func buildViewController() -> UIViewController
    func buildPresenter() -> CharactersPresenterContract
    func buildInteractor() -> CharactersInteractorContract
    func buildRouter() -> CharactersRouterContract
}

extension CharactersBuilderContract {
    func buildPresenter() -> CharactersPresenterContract {
        CharactersPresenter(wireframe: wireframe, interactor: buildInteractor(), router: buildRouter())
    }

    func buildInteractor() -> CharactersInteractorContract {
        CharactersInteractor()
    }
    
    func buildRouter() -> CharactersRouterContract {
        CharactersRouter(wireframe: wireframe)
    }
}

class CharactersBuilder: CharactersBuilderContract {
    internal let wireframe: CharactersWireframe
    
    init(wireframe: CharactersWireframe) {
        self.wireframe = wireframe
    }
    
    func buildViewController() -> UIViewController {
        let view = CharactersView.createFromStoryboard()
        view.presenter = buildPresenter()
        return view
    }
}
