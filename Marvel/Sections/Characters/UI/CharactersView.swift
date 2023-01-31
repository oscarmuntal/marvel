//
//  CharactersView.swift
//  Marvel
//
//  Created by A on 31/1/23.
//

import Foundation
import UIKit

class CharactersView: UIViewController, CreatableView {
    @IBOutlet weak var tableView: UITableView!
    var presenter: CharactersPresenterContract?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.view = self
        
    }
}

extension CharactersView: CharactersViewContract {
    
}

extension CharactersView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell")
        cell?.textLabel?.text = "Hola"
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }
}
