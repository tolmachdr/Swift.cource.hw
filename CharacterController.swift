// CharacterController.swift

import UIKit

class CharacterController: NSObject, UITableViewDelegate, UITableViewDataSource {
    private let rmClient = RMClient()
    private var characters: [RMCharacterModel] = []
    
    weak var tableView: UITableView?
    weak var viewController: UIViewController?
    
    func fetchData() async {
        do {
            self.characters = try await rmClient.character().getAllCharacters()
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        } catch {
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else {
            fatalError("Cannot dequeue")
        }
        
        let character = characters[indexPath.row]
        cell.configure(character: character)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        viewController?.performSegue(withIdentifier: "detail", sender: character)
    }
}
