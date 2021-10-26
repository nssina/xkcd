//
//  ComicCardView.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/26/21.
//

import SwiftUI

struct ComicCardView: View {
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
                .cornerRadius(12)
            
            VStack(spacing: 10) {
                
                ComicImage()
                
                ActionAndNumberView()
                
                ComicTitleAndDescriptionView()
                
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
            .frame(height: 500)
        }
        .padding()
        .frame(height: 500)
    }
}

struct ComicCardView_Previews: PreviewProvider {
    static var previews: some View {
        ComicCardView()
    }
}

struct ComicImage: View {
    var body: some View {
        Image("test")
            .resizable()
            .scaledToFill()
            .cornerRadius(8)
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
    var body: some View {
        ZStack {
            Color.bgOrange
            Text("#2530")
                .font(.system(size: 13, weight: .regular))
                .foregroundColor(.orange)
        }
        .frame(width: 50, height: 25)
        .cornerRadius(8)
    }
}

struct ActionAndNumberView: View {
    var body: some View {
        HStack {
            ActionsView()
            
            Spacer()
            
            ComicNumberView()
        }
    }
}

struct ComicTitleAndDescriptionView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Censored Vaccine Card")
                    .font(.system(size: 20, weight: .bold))
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry...")
                    .minimumScaleFactor(0.75)
                    .lineLimit(3)
            }
            Spacer()
        }
    }
}
