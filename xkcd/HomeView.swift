//
//  HomeView.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/26/21.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeVM = HomeViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "xkcd", size: 34)!]
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "xkcd", size: 17)!]
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: -20) {
                    ForEach(homeVM.comics, id:\.id) { item in
                        ComicCardView(comic: item)
                            .onAppear {
                                homeVM.loadMoreContent(currentItem: item)
                            }
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
