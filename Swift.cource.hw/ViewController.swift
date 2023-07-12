import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    var container: NSPersistentContainer!
    private var fetchedResultsController: NSFetchedResultsController<CharacterModule>!
    var appDelegate: AppDelegate {
            return UIApplication.shared.delegate as! AppDelegate
        }
    
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
    
    let fetchRequest: NSFetchRequest<CharacterModule> = CharacterModule.fetchRequest()
       
       // Configure sort descriptors if needed
       let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
       fetchRequest.sortDescriptors = [sortDescriptor]
       
       // Create the fetched results controller
       fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                             managedObjectContext: appDelegate.managedObjectContext,
                                                             sectionNameKeyPath: nil,
                                                             cacheName: nil)
       
    
       // Set the delegate to handle updates
       fetchedResultsController.delegate = self
       
       // Perform the initial fetch
       do {
           try fetchedResultsController.performFetch()
       } catch {
           print("Error fetching data: \(error)")
       }
   
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
            Task {
                do {
                    self.characters = try await rmClient.character().getAllCharacters()
                    DispatchQueue.main.async {
                        self.table.reloadData()
                    }
                    
                    var network = NetworkHandler()
                    let characterEntity = try await network.performAPIRequestAndParseResponse(method: "character")
                                
                                // Once the update is complete, reload the fetched results controller to reflect the changes in the UI
                                try fetchedResultsController.performFetch()
                                table.reloadData()
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
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else {
            fatalError("Cannot dequeue")
        }
        
        let character = fetchedResultsController.object(at: indexPath)
        // Configure the cell with the character data
        
        return cell
    }

//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return characters.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = table.dequeueReusableCell(withIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else {
//            fatalError("Cannot dequeue")
//        }
//
//        cell.configure(character: characters[indexPath.row])
//
//        return cell
//    }
   
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
           // Begin updates to your user interface (e.g., table view, collection view)
           table.beginUpdates()
       }
       
       func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                       didChange anObject: Any,
                       at indexPath: IndexPath?,
                       for type: NSFetchedResultsChangeType,
                       newIndexPath: IndexPath?) {
           switch type {
           case .insert:
               if let newIndexPath = newIndexPath {
                   // Insert a new row in your user interface
                   table.insertRows(at: [newIndexPath], with: .automatic)
               }
           case .delete:
               if let indexPath = indexPath {
                   // Delete a row from your user interface
                   table.deleteRows(at: [indexPath], with: .automatic)
               }
           case .update:
               if let indexPath = indexPath {
                   // Update a row in your user interface
                   table.reloadRows(at: [indexPath], with: .automatic)
               }
           case .move:
               if let indexPath = indexPath, let newIndexPath = newIndexPath {
                   // Move a row in your user interface
                   table.moveRow(at: indexPath, to: newIndexPath)
               }
           @unknown default:
               break
           }
       }
       
       func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
           // End updates to your user interface
           table.endUpdates()
       }
}
