//
//  CharacterModule+CoreDataProperties.swift
//  Swift.cource.hw
//
//  Created by mirrindahh on 10.07.2023.
//
//

import Foundation
import CoreData


extension CharacterModule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterModule> {
        return NSFetchRequest<CharacterModule>(entityName: "CharacterModule")
    }

    @NSManaged public var name: String?
    @NSManaged public var location: String?
    @NSManaged public var gender: String?
    @NSManaged public var status: String?
    @NSManaged public var species: String?

}

extension CharacterModule : Identifiable {

}
