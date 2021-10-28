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
    
    func searchInComics(in searchText: String) -> ComicsModel {
        return self.comics.filter { $0.title.lowercased().contains(searchText.lowercased()) || $0.alt.lowercased().contains(searchText.lowercased()) || String($0.id).lowercased().contains(searchText.lowercased()) || searchText.isEmpty }
    }
    
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
