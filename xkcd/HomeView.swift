//
//  HomeView.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/26/21.
//

import SwiftUI

struct HomeView: View {
    @State private var comics = ComicsModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "xkcd", size: 34)!]
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "xkcd", size: 17)!]
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: -20) {
                    ForEach(comics, id:\.id) { item in
                        ComicCardView(comic: item)
                    }
                }
            }
            .navigationBarTitle("xkcd")
            .onAppear(perform: getComics)
        }
    }
    
    func getComics() {
        NetworkManager.shared.getComics(since: 2499) { result in
            switch result {
            case .success(let comics):
                self.comics = comics.reversed()
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
