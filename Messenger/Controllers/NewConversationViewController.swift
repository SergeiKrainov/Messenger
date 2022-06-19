//
//  NewConversationViewController.swift
//  Messenger
//
//  Created by Sergey on 27.05.2022.
//

import UIKit
import JGProgressHUD 

class NewConversationViewController: UIViewController {
    
    private let spinner = JGProgressHUD(style: .dark)

    
    private var searchBar: UISearchBar = {
        let searhBar = UISearchBar()
        searhBar.placeholder = "Search for Users..."
        return searhBar
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.isHidden = true
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
        return table
    }()
    
    private let noResultLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "NO Results"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .medium)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(dissmisSelf))
        searchBar.becomeFirstResponder()
    }
    
    @objc private func dissmisSelf() {
        dismiss(animated: true, completion: nil)
    }
    
                                                            

}

extension NewConversationViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
