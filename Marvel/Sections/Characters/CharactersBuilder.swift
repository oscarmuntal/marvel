//
//  CharactersBuilder.swift
//  Marvel
//
//  Created by A on 31/1/23.
//

import Foundation
import UIKit

class CharactersBuilder: Builder {
    private let wireframe: CharactersWireframe
    
    init(wireframe: CharactersWireframe) {
        self.wireframe = wireframe
    }
    
    func build() -> UIViewController {
        let view = CharactersView.createFromStoryboard()
        view.presenter = build()
        return view
    }
}

private extension CharactersBuilder {
    func build() -> CharactersPresenterContract {
        CharactersPresenter(wireframe: wireframe, interactor: build())
    }

    func build() -> CharactersInteractorContract {
        CharactersInteractor()
    }
}
