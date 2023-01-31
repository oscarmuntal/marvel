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
        CharactersView.createFromStoryboard()
    }
}
