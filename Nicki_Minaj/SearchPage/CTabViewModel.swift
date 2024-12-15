//
//  CTabViewModel.swift
//  Nicki_Minaj
//
//  Created by Giorgi Michitashvili on 5/31/24.
//

import Foundation
import SwiftUI

protocol CTabViewModelDelegate: AnyObject{
    func didUpdateData()
    func didFailWithError(error: Error)
}

class CTabViewModel: ObservableObject {
    
}

