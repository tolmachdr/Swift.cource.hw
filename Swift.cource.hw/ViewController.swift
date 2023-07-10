import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let rmClient = RMClient()

    var characters: [RMCharacterModel] = []
    
    private var table: UITableView = {
        
        let table = UITableView()
        table.backgroundColor = .systemBackground
        table.allowsSelection = true
        table.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.identifier)
        return table
    }()
    
    let scroll = UIScrollView()
    
    
override func viewDidLoad() {
    super.viewDidLoad()
   
    view.addSubview(scroll)
    self.setupUI()
    
    
    scroll.translatesAutoresizingMaskIntoConstraints = false
    scroll.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    scroll.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    scroll.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
    self.table.delegate = self
    self.table.dataSource = self
    fetchCharacters()
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
    
    private func fetchCharacters() {
            async {
                do {
                    self.characters = try await rmClient.character().getAllCharacters()
                    DispatchQueue.main.async {
                        self.table.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
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
//                print(characters[indexPath.row].image)
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

