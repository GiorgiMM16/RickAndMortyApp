//
//  ContentView.swift
//  Nicki_Minaj
//
//  Created by Giorgi Michitashvili on 5/31/24.
//

import SwiftUI
import SimpleNetworking

struct ContentView: View {
    var body: some View {
        TabView{
            ATabView(viewModel: ATabViewModel(webService: WebService()))
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Characters")
                }
            BTabView(viewModel: BTabViewModel(webService: WebService()))
                .tabItem {
                    Image(systemName: "movieclapper")
                    Text("Episodes")
                }
            CTabView(viewModel: BTabViewModel(webService: WebService()), viewModel1: ATabViewModel(webService: WebService()))
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        }
        .accentColor(.red)
    }
}

#Preview {
    ContentView()
}
