//
//  RootWireframe.swift
//  Marvel
//
//  Created by Òscar Muntal on 31/1/23.
//

import Foundation
import UIKit

class RootWireframe: RootAwareWireframe {
    var rootViewController: UINavigationController?
    static let shared = RootWireframe()
}

extension RootWireframe: Pushable, CharacterDetailOpener, CharactersWireframe, CharacterDetailWireframe {}
