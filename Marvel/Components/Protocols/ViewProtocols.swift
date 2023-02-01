//
//  ViewProtocols.swift
//  Marvel
//
//  Created by Òscar Muntal on 31/1/23.
//

import Foundation
import UIKit

protocol CreatableView {
    static func createFromStoryboard() -> Self
}

extension CreatableView where Self: UIViewController {
    static func createFromStoryboard() -> Self {
        UIStoryboard(name: String(describing: self), bundle: Bundle(for: self))
            .instantiateViewController(withIdentifier: String(describing: self)) as! Self
    }
}

protocol ReloadAwareView {
    func reload()
}

extension ReloadAwareView where Self: ViewWithTable {
    func reload() {
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
}

protocol ViewWithTable {
    var table: UITableView { get }
}
