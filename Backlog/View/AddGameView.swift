//
//  AddGame.swift
//  Backlog
//
//  Created by User on 26/02/26.
//

import SwiftUI
import SwiftData
import PhotosUI

struct AddGameView: View {
    @Environment(\.dismiss) private var dismiss

    @Environment(\.modelContext)
    private var modelContext
    
    @State private var imageData: Data? = nil
    @State private var newImage: PhotosPickerItem? = nil
    @State private var newGameName: String = ""
    @State private var newGameType: GameType = .digital
    @State private var newGameStatus: GameStatus = .select
    @State private var newGameReview: String = ""
    @State private var selectedStar: Int = 0
    @State private var newDescription: String = ""
    @State private var newGameGenre: GameGenre = .select

    var body: some View {
        NavigationStack {
            Form{
                Section() {
                    PhotosPicker(selection: $newImage) {
                        Group {
                            if let imageData, let uiImage = UIImage(data: imageData) {
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
                    }
                    .listRowBackground(Color.clear)
                    .onChange(of: newImage) {
                        guard let newImage else { return }
                        Task {
                            imageData = try await newImage.loadTransferable(type: Data.self)
                        }
                    }
                }
                Section(header: Text("Nome*")) {
                    TextField("Nome do jogo", text: $newGameName)
                }
                
                Section(header: Text("Status*")) {
                    Picker("Escolha o status", selection: $newGameStatus){
                        Text("Nenhum").tag(GameStatus.select)
                        Text("Jogando").tag(GameStatus.playing)
                        Text("Joguei").tag(GameStatus.played)
                        Text("Quero Jogar").tag(GameStatus.wantToPlay)
                        Text("Abandonado").tag(GameStatus.abandoned)
                    }
                    .pickerStyle(.menu)
                }
                
                Section(header: Text("Modalidade*")) {
                    Picker("Escolha a modalidade", selection: $newGameType){
                        Text("Digital").tag(GameType.digital)
                        Text("Tabuleiro").tag(GameType.physical)
                    }
                    .pickerStyle(.palette)
                }
                
                Section(header: Text("Descrição")) {
                    TextField("Descrição do Jogo", text: $newDescription, axis: .vertical)
                        .frame(height: 60, alignment: .topLeading)
                }
                
                Section(header: Text("Gênero")) {
                    Picker("Escolha o gênero", selection: $newGameGenre){
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
                                selectedStar = index
                            }) {
                                Image(systemName: index <= selectedStar ? "star.fill" : "star")
                            }
                        }
                    }
                    .buttonStyle(.plain)
                    .font(Font.system(size: 30))
                    .foregroundStyle(.orange)
                    .frame(maxWidth: .infinity, alignment: .center)
                    TextField("Review", text: $newGameReview, axis: .vertical)
                        .frame(height: 60, alignment: .topLeading)
                }
            }
            .navigationBarTitle("Novo Jogo")
            .toolbarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .confirmationAction){
                    Button {
                        addGame()
                        dismiss()
                    }
                    label: {
                        Image(systemName: "checkmark")
                    }
                    //.buttonStyle(.borderedProminent)
                    .tint(.accentColor)
                    .disabled(newGameName.isEmpty || newGameStatus == .select)
                }
            }
        }
    }
    
    func addGame() {
        let newGame = Game(
            name: newGameName, status: newGameStatus, review: newGameReview, type: newGameType, starRating: selectedStar, gameDescription: newDescription, genre: newGameGenre, image: imageData
        )
        
        modelContext.insert(newGame)
    }
}

#Preview {
//    @Previewable @State var gameCollection: [Game] = []
    AddGameView()
}
