// ViewController.swift

import UIKit

class ViewController: UIViewController {
    private let characterController = CharacterController()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        characterController.tableView = tableView
        characterController.viewController = self
        tableView.delegate = characterController
        tableView.dataSource = characterController
        
        async {
            await characterController.fetchData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail", let character = sender as? RMCharacterModel {
            if let destination = segue.destination as? CharacterViewController {
                destination.character = character
            }
        }
    }
}
