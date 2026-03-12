//
//  Game.swift
//  Backlog
//
//  Created by User on 27/02/26.
//

import SwiftUI
import SwiftData

@Model
class Game {
    var id = UUID()
    var name: String
    var status: GameStatus
    var review: String
    var type: GameType
    var starRating: Int
    var gameDescription: String
    var genre: GameGenre
    var image: Data?
    
    init(name: String, status: GameStatus, review: String, type: GameType, starRating: Int, gameDescription: String, genre: GameGenre, image: Data? = nil) {
        self.name = name
        self.status = status
        self.review = review
        self.type = type
        self.starRating = starRating
        self.gameDescription = gameDescription
        self.genre = genre
        self.image = image
    }
}
