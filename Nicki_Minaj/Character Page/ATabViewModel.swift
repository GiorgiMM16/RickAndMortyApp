//
//  ATabViewModel.swift
//  Nicki_Minaj
//
//  Created by Giorgi Michitashvili on 5/31/24.
//

import Foundation
import SwiftUI
import SimpleNetworking

protocol ATabViewModelDelegate: AnyObject {
    func didUpdateData()
    func didFailWithError(error: Error)
}

class ATabViewModel: ObservableObject {
    
    @Published var characters: [Character] = []
    
    weak var delegate: ATabViewModelDelegate?
    
    let webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func fetchCharacters() {
        let urlString = "https://rickandmortyapi.com/api/character"
        
        webService.fetchData(from: urlString, resultType: CharacterResponse.self) { [weak self] result in
            switch result {
            case.success(let response):
                self?.characters = response.results
                self?.delegate?.didUpdateData()
            case.failure(let error):
                self?.delegate?.didFailWithError(error: error)
            }
            
        }
    }
}
