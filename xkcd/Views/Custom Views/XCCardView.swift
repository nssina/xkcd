//
//  ComicCardView.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/26/21.
//

import SwiftUI

struct XCCardView: View {
    @State private var isShowingSafari = false
    @StateObject private var viewModel = XCCardViewModel()
    
    var comic: ComicModel
    
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
                .cornerRadius(12)
            
            VStack(spacing: 15) {
                
                XCImageView(url: comic.imgs[0].sourceURL)
                
                HStack {
                    XCActionView(comic: comic, isFavorited: viewModel.checkFavorited(for: comic.id), id: comic.id)
                    Spacer()
                    XCNumberView(number: comic.id)
                }
                
                XCTextsView(title: comic.title, desc: comic.alt)
                
                Button {
                    isShowingSafari.toggle()
                    HapticGenerator.shared.soft()
                } label: {
                    HStack {
                        HStack {
                            Text("Explanation")
                                .font(.custom(CustomFont.xkcd, size: 17))
                                .foregroundColor(.blue)
                            Image(systemName: SFSymbols.arrow)
                                .font(Font.body.weight(.bold))
                                .foregroundColor(.blue)
                        }
                        .sheet(isPresented: $isShowingSafari) {
                            SafariView(url: comic.explainURL)
                                .ignoresSafeArea()
                        }
                    }
                    Spacer()
                    Text(comic.publishedAt.changeFormat())
                        .font(.custom(CustomFont.xkcd, size: 13))
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .padding()
    }
}

struct ComicCardView_Previews: PreviewProvider {
    static var previews: some View {
        XCCardView(comic: Examples.sampleComic)
    }
}
