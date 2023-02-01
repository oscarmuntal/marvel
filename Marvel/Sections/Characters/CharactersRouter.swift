//
//  CharactersRouter.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//


protocol CharactersRouterContract {
    func didSelect(item: Int)
}

class CharactersRouter {
    private let wireframe: CharactersWireframe
    
    init(wireframe: CharactersWireframe) {
        self.wireframe = wireframe
    }
}

extension CharactersRouter: CharactersRouterContract {
    func didSelect(item: Int) {
        wireframe.openCharacterDetail(with: item)
    }
}
