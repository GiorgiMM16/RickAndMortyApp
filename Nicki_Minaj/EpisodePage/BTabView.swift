//
//  BTabView.swift
//  Nicki_Minaj
//
//  Created by Giorgi Michitashvili on 5/31/24.
//

import SwiftUI
import SimpleNetworking

struct BTabView: View {
    @ObservedObject var viewModel: BTabViewModel

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.episodes) { episode in
                        VStack(alignment: .leading) {
                            Text(episode.name)
                                .font(.headline)
                            Text(episode.air_date)
                                .font(.subheadline)
                            Text(episode.episode)
                                .font(.caption)
                        }
                        .padding()
                        .frame(width: 150, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }
                .padding()
            }
            .navigationTitle("Episodes")
            .onAppear {
                viewModel.fetchEpisodes()
            }
        }
    }
}



#Preview {
    BTabView(viewModel: BTabViewModel(webService: WebService()))
}
