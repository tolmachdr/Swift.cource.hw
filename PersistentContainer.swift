//
//  PersistentContainer.swift
//  Swift.cource.hw
//
//  Created by mirrindahh on 10.07.2023.
//

import UIKit
import CoreData

class PersistentContainer: NSPersistentContainer {
    func saveContext(backgroundContext: NSManagedObjectContext? = nil) { let context = backgroundContext ?? viewContext
        guard context.hasChanges else { return }
        do {
        try context.save()
        } catch let error as NSError {
                    print("Error: \(error), \(error.userInfo)")
                }
        }
}
