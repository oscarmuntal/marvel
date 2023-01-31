//
//  CharactersBuilder.swift
//  Marvel
//
//  Created by A on 31/1/23.
//

import Foundation
import UIKit

protocol CharactersBuilderContract: Builder {
    var wireframe: CharactersWireframe { get }
    func build() -> UIViewController
    func build() -> CharactersPresenterContract
    func build() -> CharactersInteractorContract
}

extension CharactersBuilderContract {
    func build() -> CharactersPresenterContract {
        CharactersPresenter(wireframe: wireframe, interactor: build())
    }

    func build() -> CharactersInteractorContract {
        CharactersInteractor()
    }
}

class CharactersBuilder: CharactersBuilderContract {
    internal let wireframe: CharactersWireframe
    
    init(wireframe: CharactersWireframe) {
        self.wireframe = wireframe
    }
    
    func build() -> UIViewController {
        let view = CharactersView.createFromStoryboard()
        view.presenter = build()
        return view
    }
}
