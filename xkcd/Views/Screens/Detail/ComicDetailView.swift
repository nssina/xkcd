//
//  ComicDetailView.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/27/21.
//

import SwiftUI

struct ComicDetailView: View {
    var comic: ComicModel
    
    @State private var isShowingSafari = false
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Favorite.title, ascending: true)], animation: .default)
    private var favorites: FetchedResults<Favorite>
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Text(comic.title)
                        .font(.custom(CustomFont.xkcd, size: 20))
                    
                    XCImageView(url: comic.imgs[0].sourceURL)
                    
                    HStack {
                        XCActionView(comic: comic, isFavorited: checkFavorited(for: comic.id), id: comic.id)
                        Spacer()
                        Button {
                            isShowingSafari.toggle()
                            HapticGenerator.shared.soft()
                        } label: {
                            HStack {
                                Text("Explanation")
                                    .font(.custom(CustomFont.xkcd, size: 17))
                                    .foregroundColor(.blue)
                                Image(systemName: SFSymbols.arrow)
                                    .font(Font.body.weight(.bold))
                                    .foregroundColor(.blue)
                            }
                        }.sheet(isPresented: $isShowingSafari) {
                            SafariView(url: comic.explainURL)
                                .ignoresSafeArea()
                        }
                    }
                    .padding()
                    
                    HStack {
                        Text("#\(comic.id): ")
                            .foregroundColor(.orange)
                        +
                        Text(comic.alt)
                            .font(.custom(CustomFont.xkcd, size: 17))
                    }
                    .padding()
                    
                    Text(comic.publishedAt.changeFormat())
                        .font(.custom(CustomFont.xkcd, size: 13))
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
                .padding(.top, 30)
                
                Spacer()
            }
        }
        .navigationTitle("Comic")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { HapticGenerator.shared.light() }
    }
    
    private func checkFavorited(for id: Int) -> Bool {
        for i in favorites {
            guard Int(i.id) != id else { return true }
        }
        return false
    }
}

struct ComicDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ComicDetailView(comic: Examples.sampleComic)
    }
}
