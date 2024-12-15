import SwiftUI
import SimpleNetworking

struct CTabView: View {
    
    @ObservedObject var viewModel: BTabViewModel
    @ObservedObject var viewModel1: ATabViewModel
    @State private var searchTerm = ""
    @State private var selectedSearch: WhatToSearch = .episode
    
    var filteredEpisodes: [Episode] {
        return viewModel.episodes.filter { $0.name.localizedCaseInsensitiveContains(searchTerm) }
    }
    
    var filteredCharacters: [Character] {
        return viewModel1.characters.filter { $0.name.localizedCaseInsensitiveContains(searchTerm) }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Search", selection: $selectedSearch) {
                    ForEach(WhatToSearch.allCases) { searchOption in
                        Text(searchOption.rawValue).tag(searchOption)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                List {
                    if selectedSearch == .episode {
                        ForEach(filteredEpisodes) { episode in
                            VStack(alignment: .leading) {
                                Text(episode.name)
                                    .font(.headline)
                                Text(episode.air_date)
                                    .font(.subheadline)
                                Text(episode.episode)
                                    .font(.caption)
                            }
                            .padding()
                            .frame(width: 300, height: 70, alignment: .leading)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                    } else {
                        ForEach(filteredCharacters) { character in
                            VStack(alignment: .leading) {
                                Text(character.name)
                                    .font(.headline)
                                Text(character.status)
                                    .font(.subheadline)
                                Text(character.species)
                                    .font(.caption)
                            }
                            .padding()
                            .frame(width: 300, height: 70, alignment: .leading)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                    }
                }
                .navigationTitle(selectedSearch.rawValue)
                .onAppear {
                    viewModel.fetchEpisodes()
                    viewModel1.fetchCharacters()
                }
                .searchable(text: $searchTerm, prompt: "Search \(selectedSearch.rawValue.lowercased())")
            }
        }
    }
}

#Preview {
    CTabView(viewModel: BTabViewModel(webService: WebService()), viewModel1: ATabViewModel(webService: WebService()))
}
