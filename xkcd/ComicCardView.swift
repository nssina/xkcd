//
//  ComicCardView.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/26/21.
//

import SwiftUI

struct ComicCardView: View {
    var comic: ComicModel
    
    @State private var isShowingSafari = false
    
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
                .cornerRadius(12)
            
            VStack(spacing: 15) {
                
                ComicImage(url: comic.imgs[0].sourceURL)
                
                ActionAndNumberView(number: comic.id, comic: comic)
                
                ComicTitleAndDescriptionView(title: comic.title, desc: comic.alt)
                
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
                        
                        Spacer()
                    }
                }.sheet(isPresented: $isShowingSafari) {
                    SafariView(number: comic.id)
                        .ignoresSafeArea()
                }
            }
            .padding()
        }
        .padding()
    }
}

struct ComicCardView_Previews: PreviewProvider {
    static var previews: some View {
        ComicCardView(comic: ComicModel(id: 0, publishedAt: "", news: "", safeTitle: "", title: "", transcript: "", alt: "", sourceURL: "", explainURL: "", interactiveURL: "", imgs: [ComicImageModel(height: 0, width: 0, ratio: 0.0, sourceURL: "", size: "")]))
    }
}

struct ComicImage: View {
    var url: String
    
    var body: some View {
        AsyncImage(url)
    }
}

struct ActionsView: View {
    
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
                
            } label: {
                Image(systemName: SFSymbols.send)
                    .resizable()
                    .foregroundColor(.primary)
                    .frame(width: 25, height: 25)
            }
        }
    }
}

struct ComicNumberView: View {
    var number: Int
    
    var body: some View {
        ZStack {
            Color.bgOrange
            Text("#\(number)")
                .font(.custom(CustomFont.xkcd, size: 13))
                .foregroundColor(.orange)
        }
        .frame(width: 60, height: 25)
        .cornerRadius(8)
    }
}

struct ActionAndNumberView: View {
    var number: Int
    var comic: ComicModel
    
    var body: some View {
        HStack {
            ActionsView(comic: comic, id: number)
            
            Spacer()
            
            ComicNumberView(number: number)
        }
    }
}

struct ComicTitleAndDescriptionView: View {
    var title: String
    var desc: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .bold()
                    .font(.custom(CustomFont.xkcd, size: 20))
                Text(desc)
                    .font(.custom(CustomFont.xkcd, size: 15))
                    .minimumScaleFactor(0.75)
                    .lineLimit(3)
            }
            Spacer()
        }
    }
}
