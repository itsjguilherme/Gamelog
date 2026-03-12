//
//  ContentView.swift
//  Backlog
//
//  Created by User on 25/02/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Game.name) var gameCollection: [Game]
    
    @State private var searchResults: [Game] = []
    @State private var searchText: String = ""
    
    var isSearching: Bool {
        return !searchText.isEmpty
    }
    var body: some View {
        NavigationStack{
            List {
                if isSearching {
                    ForEach(searchResults) { game in
                        NavigationLink(destination: GamePageView(game: game)) {
                            GameRowView(game: game)
                                .frame(minHeight: 100)
                        }
                    }
                } else {
                    ForEach(gameCollection.enumerated(), id: \.offset) { index, game in
                        
                        NavigationLink(destination: GamePageView(game: game)) {
                            GameRowView(game: game)
                        }
                        .swipeActions(edge: .leading){
                            NavigationLink(destination: EditGameView(game: game)) {
                                Image(systemName: "square.and.pencil")
                                Text("Edit")
                            }
                            .tint(Color(.systemBlue))
                        }
                    }
                    .onDelete{ offsets in
                        for index in offsets {
                            let game = gameCollection[index]
                            modelContext.delete(game)
                        }
                    }
                }
            }
            .listRowSpacing(8)
            .toolbar {
                DefaultToolbarItem(kind: .search, placement: .bottomBar)
                ToolbarSpacer(.flexible, placement: .bottomBar)
                ToolbarItemGroup (placement: .bottomBar){
                    NavigationLink(destination: AddGameView()) {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle("Meus Jogos")
            .contentMargins(.top, 18)
            .searchable(text: $searchText, prompt: "Buscar Jogo")
            .textInputAutocapitalization(.never)
            
            .onChange(of: searchText) {
                self.fetchSearchResults(for: searchText)
            }
            .overlay {
                if isSearching && searchResults.isEmpty {
                    ContentUnavailableView(
                        "Jogo não encontrado",
                        systemImage: "magnifyingglass",
                        description: Text("Nenhum resultado encontrado para **\u{22}\(searchText)\u{22}**")
                    )
                }
            }
        }
    }
    
    private func fetchSearchResults(for query: String) {
        searchResults = gameCollection.filter { game in game.name
                .lowercased()
                .hasPrefix(searchText.lowercased())
        }
    }
    
}



#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Game.self, configurations: configuration)
    
    var gameCollection: [Game] = [
        Game(
            name: "Harmonies",
            status: .played,
            review: "Muito fácil de aprender e satisfatório de jogar",
            type: .physical,
            starRating: 4,
            gameDescription: "Isso é um jogo",
            genre: .card
//            image: "Overcooked"
        ),
        Game(
            name: "Stardew Valley",
            status: .abandoned,
            review: "",
            type: .digital,
            starRating: 2,
            gameDescription: "Isso é um jogo",
            genre: .simulation,
//            image: "Overcooked"
        ),
        Game(
            name: "Overcooked! 2",
            status: .wantToPlay,
            review: "",
            type: .digital,
            starRating: 4,
            gameDescription: "Isso é um jogo",
            genre: .casual,
            //image: "Overcooked"
        ),
        Game(
            name: "Patchwork",
            status: .wantToPlay,
            review: "",
            type: .physical,
            starRating: 5,
            gameDescription: "Isso é um jogo",
            genre: .casual
//            image: "Overcooked"
        )
    ]
    
    for game in gameCollection {
        container.mainContext.insert(game)
    }
    
    
    return ContentView()
        .modelContainer(container)
}
