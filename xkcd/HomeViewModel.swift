//
//  HomeViewModel.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/26/21.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var comics = ComicsModel()
    
    var page = 2510
    
    init() { getComics() }
    
    func loadMoreContent(currentItem item: ComicModel) {
        if item.id - 3 == page {
            page -= 30
            getComics()
        }
    }
    
    func getComics() {
        NetworkManager.shared.getComics(since: page) { result in
            switch result {
            case .success(let comics):
                DispatchQueue.main.async {
                    self.comics = comics.reversed()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}