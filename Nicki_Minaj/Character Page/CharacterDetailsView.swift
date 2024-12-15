import SwiftUI

struct CharacterDetailsView: View {
    
    var character: Character
    
    @ObservedObject var viewModel: CharacterDetailsViewModel
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: character.image))
            Text("name: \(character.name)")
            Text("gender: \(character.gender)")
            Text("status: \(character.status)")
            Text("species: \(character.species)")
            
            ScrollView{
                LazyVStack {
                    ForEach(viewModel.episodes) { episode in
                        VStack(alignment: .leading) {
                            Text("\(episode.name)")
                            Text("\(episode.air_date)")
                            Text(" \(episode.episode)")
                        }
                        .frame(width: 300, height: 80, alignment: .leading)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchEpisodes(urlStrings: character.episode)
        }
    }
}
