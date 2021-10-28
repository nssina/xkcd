//
//  HomeView.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/26/21.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            if viewModel.comics.isEmpty {
                ProgressView()
                    .navigationBarTitle("xkcd")
                    .navigationViewStyle(StackNavigationViewStyle())
            } else {
                ScrollView {
                    LazyVStack(spacing: -20) {
                        ForEach(viewModel.comics, id:\.id) { item in
                            ComicCardView(comic: item)
                                .onAppear {
                                    viewModel.loadMoreContent(currentItem: item)
                                }
                        }
                    }
                }
                .navigationBarTitle("xkcd")
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
