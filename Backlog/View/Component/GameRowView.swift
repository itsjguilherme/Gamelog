//
//  GameRowView.swift
//  Backlog
//
//  Created by User on 05/03/26.
//

import SwiftUI

struct GameRowView: View {
    var game : Game
    
    var body: some View {
        HStack(spacing: 14) {
            if let data = game.image {
                if let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 75, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                }
            } else {
                Image(systemName: "gamecontroller.circle.fill")
                    .font(.largeTitle)
                    .frame(width: 75, height: 100)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    .foregroundColor(.white)
            }
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(game.name)
                        .lineLimit(2)
                        .foregroundColor(.primary)
                        .font(.system(.headline))
                    
                    if (!(game.starRating == 0)) {
                        HStack(spacing: 0) {
                            ForEach(1...5, id: \.self) { index in
                                Image(systemName: index <= game.starRating ? "star.fill" : "")
                            }
                        }
                        .font(.subheadline)
                        .foregroundColor(.accentColor)
                    }
                }
                Spacer()
                Text(game.status.text)
                    .font(.subheadline)
                    .padding([.top, .bottom], 4)
                    .padding([.leading, .trailing], 8)
                    .background(game.status.color, in: RoundedRectangle(cornerRadius: 12))
            }
            Spacer()
        }
        
    }
}

#Preview {
    GameRowView(game: Game(name: "Azul", status: .played, review: "Muito legal", type: .physical, starRating: 3, gameDescription: "Isso é um jogo", genre: .casual
))
}
