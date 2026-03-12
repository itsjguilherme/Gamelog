//
//  GameType.swift
//  Backlog
//
//  Created by User on 04/03/26.
//

enum GameType: Identifiable, Codable {
    case digital, physical
    
    var id: Self { self }
    
    var icon: String {
        switch self {
        case .physical:
            return "🎲"
        case .digital:
            return "🎮"
        }
    }
    
    var text: String {
        switch self {
        case .physical:
            return "Jogo de Tabuleiro"
        case .digital:
            return "Jogo digital"
        }
    }
}
