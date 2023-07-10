//
//  CharacterMod+CoreDataProperties.swift
//  Swift.cource.hw
//
//  Created by mirrindahh on 10.07.2023.
//
//

import Foundation
import CoreData


extension CharacterMod {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterMod> {
        return NSFetchRequest<CharacterMod>(entityName: "CharacterMod")
    }

    @NSManaged public var name: String?
    @NSManaged public var status: String?
    @NSManaged public var species: String?
    @NSManaged public var type: String?
    @NSManaged public var gender: String?
    @NSManaged public var location: String?

}

extension CharacterMod : Identifiable {

}
