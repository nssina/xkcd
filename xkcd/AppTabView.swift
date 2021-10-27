//
//  AppTabView.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/26/21.
//

import SwiftUI

struct AppTabView: View {
    
    init() { UINavigationBar().setFont("xkcd", largeSize: 34, inlineSize: 17) }
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: SFSymbols.comics)
                }
            SearchView()
                .tabItem {
                    Label("Search", systemImage: SFSymbols.search)
                }
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: SFSymbols.fillFavorite)
                }
        }
        .accentColor(.primary)
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
