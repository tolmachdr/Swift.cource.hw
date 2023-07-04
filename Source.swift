//
//  Source.swift
//  Swift.cource.hw
//
//  Created by Kulbatchayev Timyr on 02.07.2023.
//

import Foundation
import UIKit

struct Character {
enum Status {
case alive
case dead
case unknown
}

enum Gender {
    case female
    case male
    case genderless
    case unknown
}

let id: Int
let name: String
let status: Status
let species: String
let gender: Gender
let location: String
    let image: String

struct Source {
    static func makeCharacter() -> [Character] {
        [
            .init(id: 1, name: "Rick", status: Status.alive, species: "Human", gender: Character.Gender.male, location: "Earth", image: "RS"),
            .init(id: 2, name: "Morty", status: Status.alive, species: "Human", gender: Character.Gender.male, location: "Earth", image: "MS"),
            .init(id: 3, name: "Summer", status: Status.alive, species: "Human", gender: Character.Gender.female, location: "Earth", image: "SS"),
            .init(id: 4, name: "Beth", status: Status.alive, species: "Human", gender: Character.Gender.female, location: "Earth", image: "BS"),
            .init(id: 5, name: "Jerry", status: Status.alive, species: "Human", gender: Character.Gender.male, location: "Earth", image: "JS"),
            .init(id: 6, name: "Squanchy", status: Status.unknown, species: "Cat-like anthropomorphic creature", gender: Character.Gender.unknown, location: "Earth", image: "Sq"),
            .init(id: 7, name: "Birdperson", status: Status.alive, species: "Humanoid with bird-like features", gender: Character.Gender.male, location: "Earth", image: "Bp"),
            .init(id: 8, name: "Mr. Goldenfold", status: Status.alive, species: "Human", gender: Character.Gender.male, location: "Earth", image: "MG"),
            .init(id: 9, name: "Morty Jr.", status: Status.alive, species: "Human + Gazorpian", gender: Character.Gender.male, location: "Bird World", image: "MJS"),
            
            
        ]
    }
}
}
