//
//  Client.swift
//  Swift.cource.hw
//
//  Created by mirrindahh on 07.07.2023.
//

import Foundation


public struct RMClient {
    
    public init() {}
    
    /**
     Access character struct.
     - Returns: Character struct.
     */
    public func character() -> RMCharacter {
        let character = RMCharacter(client: self)
        return character
    }
}
