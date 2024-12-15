//
//  BTabViewModel.swift
//  Nicki_Minaj
//
//  Created by Giorgi Michitashvili on 5/31/24.
//

import Foundation
import SwiftUI
import SimpleNetworking

protocol CharacterDetailsViewModelDelegate: AnyObject{
    func didUpdateData()
    func didFailWithError(error: Error)
}

class CharacterDetailsViewModel: ObservableObject {
    
    let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=6535d0aa299d5d27cd8aacee4c8b09af"
    
    @Published var episodes: [Episode] = []
    
    weak var delegate: CharacterDetailsViewModelDelegate?
    
    let webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func fetchEpisodes(urlStrings: [String]) {
        let dispatchGroup = DispatchGroup()
        
        for urlString in urlStrings {
            dispatchGroup.enter()
            webService.fetchData(from: urlString, resultType: Episode.self) { [weak self] result in
                switch result {
                case .success(let episode):
                    DispatchQueue.main.async {
                        self?.episodes.append(episode)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.delegate?.didFailWithError(error: error)
                    }
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.delegate?.didUpdateData()
        }
    }
}
