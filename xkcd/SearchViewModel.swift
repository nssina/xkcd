//
//  SearchViewModel.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/27/21.
//

import Foundation
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var comics = ComicsModel()
    
    init() { getComics() }
    
    private func getComics() {
        NetworkManager.shared.getComics(since: 0) { result in
            switch result {
            case .success(let comics):
                DispatchQueue.main.async {
                    self.comics = comics.reversed()
                    HapticGenerator.shared.success()
                }
            case .failure(let error):
                print(error)
                HapticGenerator.shared.error()
            }
        }
    }
}
