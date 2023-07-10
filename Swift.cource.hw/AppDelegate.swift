//
//  AppDelegate.swift
//  Swift.cource.hw
//
//  Created by Kulbatchayev Timyr on 02.07.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var launchCount: Int = 0

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        launchCount += 1
            
            // Check if launchCount is divisible by three
            if launchCount % 3 == 0 {
                // Create and present the system alert
                let alert = UIAlertController(title: "Welcome Back!",
                                              message: "This is your \(launchCount)th launch!",
                                              preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                
                // Get the root view controller to present the alert
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
            }
        // Override point for customization after application launch.
        let fetchedResultsController = createFetchedResultsController() // Replace with your NSFetchedResultsController instance
            
            do {
                try fetchedResultsController.performFetch()
            } catch {
                print("Error fetching data: \(error)")
            }
            
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = navigationController
//        window?.makeKeyAndVisible()
//
        
        return true
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model"); container.loadPersistentStores(completionHandler: { (storeDescription, error) in
    if let error = error as NSError? {
    fatalError("Unresolved error \(error), \(error.userInfo)")
    } })
    return container }()
    
    lazy var managedObjectContext: NSManagedObjectContext = persistentContainer.viewContext


    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func createFetchedResultsController() -> NSFetchedResultsController<CharacterMod> {
        let fetchRequest: NSFetchRequest<CharacterMod> = CharacterMod.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: managedObjectContext,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        return fetchedResultsController
    }

}

