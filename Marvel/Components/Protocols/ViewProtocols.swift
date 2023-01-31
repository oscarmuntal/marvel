//
//  ViewProtocols.swift
//  Marvel
//
//  Created by Òscar Muntal on 31/1/23.
//

import Foundation
import UIKit

protocol CreatableView {
    static func createFromXib() -> Self
    static func createFromStoryboard() -> Self
}

extension CreatableView where Self: UIViewController {
    static func createFromXib() -> Self {
        .init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    static func createFromStoryboard() -> Self {
        UIStoryboard(name: String(describing: self), bundle: Bundle(for: self))
            .instantiateViewController(withIdentifier: String(describing: self)) as! Self
    }
}
