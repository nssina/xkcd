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
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Text(comic.title)
                        .font(.custom(CustomFont.xkcd, size: 20))
                    
                    AsyncImage(comic.imgs[0].sourceURL)
                    
                    HStack {
                        ButtonsView(comic: comic, id: comic.id)
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
                            SafariView(number: comic.id)
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
                    
                    Spacer()
                }
                .padding(.top, 30)
                
                Spacer()
            }
        }
        .navigationTitle("Comic")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ComicDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ComicDetailView(comic: ComicModel(id: 2533, publishedAt: "", news: "", safeTitle: "", title: "test", transcript: "", alt: "test", sourceURL: "", explainURL: "", interactiveURL: "", imgs: [ComicImageModel(height: 0, width: 0, ratio: 0.0, sourceURL: "", size: "")]))
    }
}

struct ButtonsView: View {
    @State private var isShowingShareSheet = false
    private let network = NetworkManager.shared
    
    var comic: ComicModel
    var id: Int
    
    var body: some View {
        HStack(spacing: 25) {
            Button {
                
            } label: {
                Image(systemName: SFSymbols.favorite)
                    .resizable()
                    .foregroundColor(.primary)
                    .frame(width: 25, height: 25)
            }
            
            Button {
                isShowingShareSheet.toggle()
                HapticGenerator.shared.soft()
            } label: {
                Image(systemName: SFSymbols.send)
                    .resizable()
                    .foregroundColor(.primary)
                    .frame(width: 25, height: 25)
            }
            .sheet(isPresented: $isShowingShareSheet) {
                ShareSheet(activityItems: [network.loadImage(comic.imgs[0].sourceURL), comic.title, comic.alt])
            }
        }
    }
}
