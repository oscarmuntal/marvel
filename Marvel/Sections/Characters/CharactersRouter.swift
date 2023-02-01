//
//  CharactersRouter.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//

import Foundation

protocol CharactersRouterContract {}

class CharactersRouter: CharactersRouterContract {
    private let wireframe: CharactersWireframe
    
    init(wireframe: CharactersWireframe) {
        self.wireframe = wireframe
    }
}
