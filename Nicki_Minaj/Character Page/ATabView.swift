//
//  ATabView.swift
//  Nicki_Minaj
//
//  Created by Giorgi Michitashvili on 5/31/24.
//

import SwiftUI
import SimpleNetworking

struct ATabView: View {
    
    @ObservedObject var viewModel: ATabViewModel
    
    @State private var selectedCharacter: Character?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.characters) { character in
                        VStack(alignment: .leading) {
                            Text(character.name)
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                        }
                        .padding()
                        .frame(width: 150, height: 100, alignment: .leading)
                        .background(AsyncImage(url: URL(string: character.image)))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .onTapGesture {
                            selectedCharacter = character
                        }
                        .fullScreenCover(item: $selectedCharacter) { character in
                            CharacterDetailsView(character: character, viewModel: CharacterDetailsViewModel(webService: WebService()))
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Characters")
            .onAppear {
                viewModel.fetchCharacters()
            }
        }
    }
}

#Preview {
    ATabView(viewModel: ATabViewModel(webService: WebService()))
}
