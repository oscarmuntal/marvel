//
//  CharactersContract.swift
//  Marvel
//
//  Created by A on 31/1/23.
//

import Foundation

protocol CharactersWireframe {
    
}

protocol CharactersViewContract {
    
}

protocol CharactersPresenterContract {
    var view: CharactersViewContract? { get set }
}

protocol CharactersInteractorContract {
    
}
