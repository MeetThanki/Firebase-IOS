//
//  Model.swift
//  Firebase Demo
//
//  Created by Meet Thanki on 17/03/21.
//

import Foundation


struct PlayerList : Codable{
    let players: [Players]
}

struct Players: Codable {
    let playerName : String
    let playerScore : String
}

