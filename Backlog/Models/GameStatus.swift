//
//  GameStatus.swift
//  Backlog
//
//  Created by User on 04/03/26.
//
import SwiftUI

enum GameStatus: Identifiable, Codable {
    case select, playing, played, wantToPlay, abandoned
    
    var id: Self { self }
    
    var text: String {
        switch self {
        case .playing:
            return "Jogando"
        case .played:
            return "Joguei"
        case .wantToPlay:
            return "Quero jogar"
        case .abandoned:
            return "Abandonado"
        case .select:
            return ""
        }
    }
    
    var color: Color {
        switch self {
        case .playing:
            return .blue .opacity(0.3)
        case .played:
            return .green .opacity(0.3)
        case .wantToPlay:
            return .yellow .opacity(0.3)
        case .abandoned:
            return .red .opacity(0.3)
        case .select:
            return .white
        }
    }
}
