//
//  BTabViewModel.swift
//  Nicki_Minaj
//
//  Created by Giorgi Michitashvili on 5/31/24.
//

import Foundation
import SwiftUI
import SimpleNetworking

protocol BTabViewModelDelegate: AnyObject{
    func didUpdateData()
    func didFailWithError(error: Error)
}

class BTabViewModel: ObservableObject {
    
    @Published var episodes: [Episode] = []
    
    weak var delegate: BTabViewModelDelegate?
    
    let webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func fetchEpisodes() {
        let urlString = "https://rickandmortyapi.com/api/episode"
        
        webService.fetchData(from: urlString, resultType: EpisodeResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.episodes = response.results
                    self?.delegate?.didUpdateData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.delegate?.didFailWithError(error: error)
                }
            }
        }
    }
}

