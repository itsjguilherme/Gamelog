//
//  GamePage.swift
//  Backlog
//
//  Created by User on 25/02/26.
//

import SwiftUI

struct GamePageView: View {
    var game: Game
    
    var body: some View {
        NavigationStack{
            VStack {
                List {
                    VStack(spacing: 18) {
                        if let data = game.image {
                            if let uiImage = UIImage(data: data) {
                                HStack(alignment: .center){
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 150, height: 200)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                                        .clipped()
                                }
                                .frame(maxWidth: .infinity)
                            }
                        } else {
                            HStack(alignment: .center) {
                                Image(systemName: "gamecontroller.circle.fill")
                                    .font(.largeTitle)
                                    .frame(width: 150, height: 200)
                                    .background(.blue)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        HStack {
                            VStack (alignment:.leading, spacing: 0){
                                Text(game.name)
                                    .font(.largeTitle.bold())
                                    .frame(alignment: .leading)
                                    .padding(.vertical, 16)
                                Text(game.status.text)
                                    .font(.subheadline)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 8)
                                    .background(game.status.color, in: RoundedRectangle(cornerRadius: 12))
                            }
                            Spacer()
                        }
                    }
                    .listRowBackground(Color.clear)
                    .padding(.bottom, -15)
                    
                    Section {
                        HStack {
                            Text(game.type.icon)
                                .font(.title)
                            Text(game.type.text)
                                .font(.headline)
                            Spacer()
                        }
                    }
                    
                    if (!game.gameDescription.isEmpty || !(game.genre == .select)) {
                        Section (header: Text("Informações")) {
                            Text(game.gameDescription)
                            HStack {
                                Text(game.genre.text)
                                    .font(.headline)
                            }
                        }
                    }
                    
                    if (!game.review.isEmpty || !(game.starRating == 0)) {
                        Section (header: Text("Review")) {
                            if (!(game.starRating == 0)) {
                                HStack(spacing: 6) {
                                    ForEach(1...5, id: \.self) { index in
                                        Image(systemName: index <= game.starRating ? "star.fill" : "star")
                                    }
                                }
                                .font(Font.system(size: 30))
                                .foregroundStyle(.orange)
                                .frame(maxWidth: .infinity, alignment: .center)
                            }
                            if (!game.review.isEmpty) {
                                Text(game.review)
                            }
                        }
                    }
                }
                .contentMargins(.top, 2)
                .toolbar {
                    ToolbarSpacer(.flexible, placement: .bottomBar)
                    ToolbarItem(placement: .bottomBar) {
                        NavigationLink(destination: EditGameView(game: game)) {
                            Image(systemName: "square.and.pencil")
                            //                            Text("Editar")
                        }
                        .tint(.accentColor)
                        
                    }
                }
            }
            .background(Color(red: 242/255, green: 242/255, blue: 249/255).ignoresSafeArea())
        }
        
    }
    
}

#Preview {
    GamePageView(game: Game(name: "Stardew Valley", status: .played, review: "Muito legal", type: .physical, starRating: 3, gameDescription: "Isso é um jogo", genre: .casual
                       ))
}
