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
                            .font(.custom(CustomFont.xkcd, size: 15))
                            .frame(height: 34)
                            .cornerRadius(8)
                    }
                }
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.secondary, lineWidth: 1))
                .padding([.trailing, .leading], 15)
                
                if viewModel.comics.isEmpty {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else {
                    List {
                        ForEach(viewModel.searchInComics(in: searchText)) { item in
                            NavigationLink(destination: ComicDetailView(comic: item)) {
                                SearchCell(comic: item)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Search")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
