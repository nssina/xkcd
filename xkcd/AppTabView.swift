//
//  AppTabView.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/26/21.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    SFSymbols.comics
                }
            SearchView()
                .tabItem {
                    SFSymbols.search
                }
            FavoritesView()
                .tabItem {
                    SFSymbols.favorite
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
