//
//  HomeView.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/26/21.
//

import SwiftUI

struct HomeView: View {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "xkcd", size: 34)!]
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "xkcd", size: 17)!]
    }
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 30) {
                    ForEach(0..<10, id: \.self) { item in
                        ComicCardView()
                    }
                }
            }
            .navigationBarTitle("xkcd")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
