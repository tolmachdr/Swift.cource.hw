import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//          tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "detail", sender: self)
//               let detailViewController = CharacterViewController(character: characters[indexPath.row])
//           navigationController?.pushViewController(detailViewController, animated: true)
           }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CharacterViewController {
            if let indexPath = table.indexPathForSelectedRow {
                destination.character = characters[indexPath.row]
            }
        }
    }

    
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

