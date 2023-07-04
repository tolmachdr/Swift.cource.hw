import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    var characters: [Character] = Character.Source.makeCharacter()

    private var table: UITableView = {
        
        let table = UITableView()
        table.backgroundColor = .systemBackground
        table.allowsSelection = true
        table.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.identifier)
        return table
    }()
    
    
    
override func viewDidLoad() {
    super.viewDidLoad()
   
    self.setupUI()
    
    self.table.delegate = self
    self.table.dataSource = self
    
    }
    
    private func setupUI() {
        self.view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: self.view.topAnchor),
            table.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
                    ])
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else {
            fatalError("Cannot dequeue")
        }
        
        cell.configure(character: characters[indexPath.row])
        
        return cell
    }
}

