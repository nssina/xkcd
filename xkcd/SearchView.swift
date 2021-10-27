//
//  SearchView.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/26/21.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                ZStack {
                    Color(.secondarySystemBackground)
                        .frame(height: 34)
                        .cornerRadius(8)
                    HStack {
                        Image(systemName: SFSymbols.search)
                            .padding(.leading, 5)
                            .foregroundColor(.secondary)
                        TextField("Titles, numbers or alts", text: $searchText)
                            .frame(height: 34)
                            .cornerRadius(8)
                    }
                }
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.secondary, lineWidth: 1))
                .padding([.trailing, .leading], 15)
                
                List {
                    ForEach(searchInComics()) { item in
                        NavigationLink(destination: ComicDetailView(comic: item)) {
                            SearchCell(comic: item)
                        }
                    }
                }
            }
            .navigationBarTitle("Search")
        }
    }
    
    private func searchInComics() -> ComicsModel {
        return viewModel.comics.filter { $0.title.lowercased().contains(searchText.lowercased()) || $0.alt.lowercased().contains(searchText.lowercased()) || String($0.id).lowercased().contains(searchText.lowercased()) || searchText.isEmpty }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
