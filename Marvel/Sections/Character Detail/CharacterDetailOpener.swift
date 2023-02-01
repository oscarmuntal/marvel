//
//  CharacterDetailOpener.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//

import Foundation
import UIKit

protocol CharacterDetailOpener {
    func openCharacterDetail(with id: Int)
}

extension CharacterDetailOpener where Self: Pushable, Self: CharacterDetailWireframe  {
    func openCharacterDetail(with id: Int) {
        push(viewController: CharacterDetailBuilder(wireframe: self).buildViewController())
    }
}
