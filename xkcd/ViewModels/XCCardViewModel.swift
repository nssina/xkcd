//
//  XCCardViewModel.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/28/21.
//

import SwiftUI

class XCCardViewModel: ObservableObject {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Favorite.title, ascending: true)], animation: .default)
    private var favorites: FetchedResults<Favorite>
    
    func checkFavorited(for id: Int) -> Bool {
        for i in favorites {
            guard Int(i.id) != id else { return true }
        }
        return false
    }
}
