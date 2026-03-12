//
//  GameGender.swift
//  Backlog
//
//  Created by User on 04/03/26.
//

import Foundation
import SwiftUI


enum GameGenre: Identifiable, Codable {
    case select, platform, shooter, fight, stealth, survival, survivalHorror, metroidvania, rpg, mmorpg, rouguelikes, hackNSlash, casual, arcade, puzzle, adventure, simulation, card, racing, sports
    
    var id: Self { self }
    
    var text: String {
        switch self {
        case .platform:
            return "Plataforma"
        case .shooter:
            return "Shooter"
        case .fight:
            return "Luta"
        case .stealth:
            return "Furtivo"
        case .select:
            return ""
        case .survival:
            return "Sobrevivência"
        case .survivalHorror:
            return "Survival Horror"
        case .metroidvania:
            return "Metroidvania"
        case .rpg:
            return "RPG"
        case .mmorpg:
            return "MMORPG"
        case .rouguelikes:
            return "Rouguelikes"
        case .hackNSlash:
            return "Hack N Slash"
        case .casual:
            return "Casual"
        case .arcade:
            return "Arcade"
        case .puzzle:
            return "Puzzle"
        case .adventure:
            return "Aventura"
        case .simulation:
            return "Simulação"
        case .card:
            return "Cartas"
        case .racing:
            return "Corrida"
        case .sports:
            return "Esportes"
        }
    }
    
//    var color: Color {
//        switch self {
//        case .playing:
//            return .blue .opacity(0.3)
//        case .played:
//            return .green .opacity(0.3)
//        case .wantToPlay:
//            return .yellow .opacity(0.3)
//        case .abandoned:
//            return .red .opacity(0.3)
//        case .select:
//            return .white
//        }
//    }
}
