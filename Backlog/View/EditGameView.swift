//
//  EditGame.swift
//  Backlog
//
//  Created by User on 27/02/26.
//

import SwiftUI
import SwiftData
import PhotosUI

struct EditGameView: View {
    var game: Game
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var editGameName: String = ""
    @State private var editGameType: GameType = .digital
    @State private var editGameStatus: GameStatus = .select
    @State private var editGameReview: String = ""
    @State private var editSelectedStar: Int = 0
    @State private var editDescritpion: String = ""
    @State private var editImageData: Data? = nil
    @State private var editNewImage: PhotosPickerItem? = nil
    @State private var editGameGenre: GameGenre = .adventure

    var body: some View {
        NavigationStack {
            Form{
                Section() {
                    PhotosPicker(selection: $editNewImage) {
                        Group {
                            if let editImageData, let uiImage = UIImage(data: editImageData) {
                                HStack(alignment: .center) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 200)
                                        .frame(width: 150)
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                }
                                .frame(maxWidth: .infinity)
                            } else {
                                HStack(alignment: .center) {
                                    Image(systemName: "photo.badge.plus.fill")
                                        .font(.largeTitle)
                                        .frame(height: 200)
                                        .frame(width: 150)
                                        .background(Color(white: 0.4, opacity: 0.2))
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .listRowBackground(Color.clear)
                    .onChange(of: editNewImage) {
                        guard let editNewImage else { return }
                        Task {
                            editImageData = try await editNewImage.loadTransferable(type: Data.self)
                        }
                    }
                }
                
                Section(header: Text("Nome*")) {
                    TextField(editGameName, text: $editGameName)
                }
                
                Section(header: Text("Status*")) {
                    Picker("Escolha o status", selection: $editGameStatus){
                        Text("Nenhum").tag(GameStatus.select)
                        Text("Jogando").tag(GameStatus.playing)
                        Text("Joguei").tag(GameStatus.played)
                        Text("Quero Jogar").tag(GameStatus.wantToPlay)
                        Text("Abandonado").tag(GameStatus.abandoned)
                    }
                    .pickerStyle(.menu)
                }
                
                Section(header: Text("Modalidade*")) {
                    Picker("Escolha a modalidade", selection: $editGameType){
                        Text("Digital").tag(GameType.digital)
                        Text("Tabuleiro").tag(GameType.physical)
                    }
                    .pickerStyle(.palette)
                }
                
                Section(header: Text("Descrição")) {
                    TextField("Descrição do Jogo", text: $editDescritpion, axis: .vertical)
                        .frame(height: 60, alignment: .topLeading)
                }
                
                Section(header: Text("Gênero")) {
                    Picker("Escolha o gênero", selection: $editGameGenre){
                        Text("Nenhum").tag(GameGenre.select)
                        Text("Plataforma").tag(GameGenre.platform)
                        Text("Shooter").tag(GameGenre.shooter)
                        Text("Luta").tag(GameGenre.fight)
                        Text("Furtivo").tag(GameGenre.stealth)
                        Text("Sobrevivência").tag(GameGenre.survival)
                        Text("Survival Horror").tag(GameGenre.survivalHorror)
                        Text("Metroidvania").tag(GameGenre.metroidvania)
                        Text("RPG").tag(GameGenre.rpg)
                        Text("MMORPG").tag(GameGenre.mmorpg)
                        Text("Rouguelike").tag(GameGenre.rouguelikes)
                        Text("Hack N Slash").tag(GameGenre.hackNSlash)
                        Text("Casual").tag(GameGenre.casual)
                        Text("Arcade").tag(GameGenre.arcade)
                        Text("Puzzle").tag(GameGenre.puzzle)
                        Text("Aventura").tag(GameGenre.adventure)
                        Text("Simulação").tag(GameGenre.simulation)
                        Text("Cartas").tag(GameGenre.card)
                        Text("Corrida").tag(GameGenre.racing)
                        Text("Esportes").tag(GameGenre.sports)
                    }
                    .pickerStyle(.menu)
                }
                
                Section(header: Text("Review")) {
                    HStack (spacing: 6) {
                        ForEach(1...5, id: \.self) { index in
                            Button(action: {
                                editSelectedStar = index
                            }) {
                                Image(systemName: index <= editSelectedStar ? "star.fill" : "star")
                            }
                        }
                    }
                    .buttonStyle(.plain)
                    .font(Font.system(size: 30))
                    .foregroundStyle(.orange)
                    .frame(maxWidth: .infinity, alignment: .center)
                    TextField("Review", text: $editGameReview, axis: .vertical)
                        .frame(height: 60, alignment: .topLeading)
                }
            }
            .navigationBarTitle("Editar Jogo")
            .toolbarTitleDisplayMode(.inline)
            
            .onAppear {
                editGameName = game.name
                editGameStatus = game.status
                editGameReview = game.review
                editGameType = game.type
                editSelectedStar = game.starRating
                editDescritpion = game.gameDescription
                editImageData = game.image
                editGameGenre = game.genre
            }
            
            .toolbar {
                ToolbarItem(placement: .confirmationAction){
                    Button {
                        editGame()
                        dismiss()
                    }
                    label: {
                        Image(systemName: "checkmark")
                    }
                    //.buttonStyle(.borderedProminent)
                    .tint(.accentColor)
                }
            }
        }
    }
    
    func editGame() {
        game.name = editGameName
        game.status = editGameStatus
        game.type = editGameType
        game.review = editGameReview
        game.starRating = editSelectedStar
        game.gameDescription = editDescritpion
        game.genre = editGameGenre
        game.image = editImageData
    }
}

#Preview {
    EditGameView(
        game: Game(name: "cdsac", status: .abandoned, review: "cdasca", type: .digital, starRating: 3, gameDescription: "Isso é um jogo", genre: .adventure)
    )
}
