//
//  ComicCardView.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/26/21.
//

import SwiftUI

struct ComicCardView: View {
    var comic: ComicModel
    
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
                .cornerRadius(12)
            
            VStack(spacing: 10) {
                
                ComicImage(url: comic.imgs[0].sourceURL)
                
                ActionAndNumberView(number: comic.id)
                
                ComicTitleAndDescriptionView(title: comic.title, desc: comic.alt)
                
                Button {
                    
                } label: {
                    HStack {
                        Text("Explanation")
                            .bold()
                            .foregroundColor(.blue)
                        Image(systemName: SFSymbols.arrow)
                            .font(Font.body.weight(.bold))
                            .foregroundColor(.blue)
                        
                        Spacer()
                    }
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
                .font(.system(size: 13, weight: .regular))
                .foregroundColor(.orange)
        }
        .frame(width: 50, height: 25)
        .cornerRadius(8)
    }
}

struct ActionAndNumberView: View {
    var number: Int
    
    var body: some View {
        HStack {
            ActionsView()
            
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
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                Text(desc)
                    .minimumScaleFactor(0.75)
                    .lineLimit(3)
            }
            Spacer()
        }
    }
}
