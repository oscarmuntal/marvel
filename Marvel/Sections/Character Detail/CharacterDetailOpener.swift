//
//  CharacterDetailOpener.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//

import UIKit

protocol CharacterDetailOpener {
    func openCharacterDetail(with id: Int)
}

extension CharacterDetailOpener where Self: Pushable, Self: CharacterDetailWireframe  {
    func openCharacterDetail(with id: Int) {
        push(viewController: CharacterDetailBuilder(wireframe: self, characterId: id).buildViewController())
    }
}

protocol AlertOpener {
    func openAlert(_ viewControllerToPresent: UIViewController, animated flag: Bool)
}

extension AlertOpener where Self: Presentable {
    func openAlert(_ viewControllerToPresent: UIViewController, animated flag: Bool) {
        present(viewControllerToPresent, animated: flag)
    }
}
