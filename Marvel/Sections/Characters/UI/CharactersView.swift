//
//  CharactersView.swift
//  Marvel
//
//  Created by A on 31/1/23.
//

import UIKit

class CharactersView: UIViewController, CreatableView, ViewWithTable {
    @IBOutlet weak var tableView: UITableView!
    var table: UITableView { tableView }
    var presenter: CharactersPresenterContract?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.view = self
    }
}

extension CharactersView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numCharacters() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter,
              let cell = tableView.dequeueReusableCell(withIdentifier: characterCellIdentifier, for: indexPath) as? CharactersTableViewCell else { fatalError() }
        cell.configure(with: presenter.cellViewModel(at: indexPath))
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath)
    }
}

extension CharactersView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height - 100 - scrollView.frame.height {
            rechargeTableView()
        }
    }
}

private extension CharactersView {
    func rechargeTableView() {
        guard let presenter = self.presenter, !presenter.isPaginating() else { return }
        presenter.didScroll()
    }
    
    
    func createSpinerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
}

extension CharactersView: CharactersViewContract {
    func configureTableFooter() {
        DispatchQueue.main.async {
            self.tableView.tableFooterView = self.createSpinerFooter()
        }
    }
    
    func resetTableFooter() {
        DispatchQueue.main.async {
            self.tableView.tableFooterView = nil
        }
    }
    
    func errorAlertAction() -> UIAlertAction {
        return UIAlertAction(title: "OK", style: .cancel) { action in
            self.dismiss(animated: true)
            self.rechargeTableView()
        }
    }
}
