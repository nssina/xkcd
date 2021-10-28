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
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Favorite.title, ascending: true)], animation: .default)
    private var favorites: FetchedResults<Favorite>
    
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
                .cornerRadius(12)
            
            VStack(spacing: 15) {
                
                ComicImage(url: comic.imgs[0].sourceURL)
                
                ActionAndNumberView(number: comic.id, comic: comic, isFavorited: checkFavorited(for: comic.id))
                
                ComicTitleAndDescriptionView(title: comic.title, desc: comic.alt)
                
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
    
    private func checkFavorited(for id: Int) -> Bool {
        for i in favorites {
            guard Int(i.id) != id else { return true }
        }
        return false
    }
}

struct ComicCardView_Previews: PreviewProvider {
    static var previews: some View {
        ComicCardView(comic: ComicModel(id: 0, publishedAt: "", news: "", safeTitle: "", title: "", transcript: "", alt: "", sourceURL: "", explainURL: "", interactiveURL: "", imgs: [ComicImageModel(height: 0, width: 0, ratio: 0.0, sourceURL: "", size: "")]))
    }
}

struct ComicImage: View {
    var url: String
    
    @GestureState private var scale: CGFloat = 1.0
    
    var body: some View {
        AsyncImage(url).scaleEffect(scale)
            .gesture(MagnificationGesture().updating($scale, body: { newValue, scale, _ in
                scale = newValue
            }))
    }
}

struct ActionsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isShowingShareSheet = false
    private let network = NetworkManager.shared
    
    var comic: ComicModel
    var isFavorited: Bool
    var id: Int
    
    var body: some View {
        HStack(spacing: 25) {
            Button {
                saveComic()
            } label: {
                Image(systemName: isFavorited ? SFSymbols.favorited : SFSymbols.favorite)
                    .resizable()
                    .foregroundColor(.primary)
                    .frame(width: 20, height: 20)
            }
            
            Button {
                isShowingShareSheet.toggle()
                HapticGenerator.shared.soft()
            } label: {
                Image(systemName: SFSymbols.send)
                    .resizable()
                    .foregroundColor(.primary)
                    .frame(width: 20, height: 20)
            }
            .sheet(isPresented: $isShowingShareSheet) {
                ShareSheet(activityItems: [network.loadImage(comic.imgs[0].sourceURL), comic.title, comic.alt])
            }
        }
    }
    
    private func saveComic() {
        withAnimation {
            let newFavotite = Favorite(context: viewContext)
            newFavotite.alt = comic.alt
            newFavotite.id = Int16(comic.id)
            newFavotite.image = network.getImageData(comic.imgs[0].sourceURL)
            newFavotite.title = comic.title
            newFavotite.date = comic.publishedAt.changeFormat()
            newFavotite.explainURL = comic.explainURL

            do {
                try viewContext.save()
                HapticGenerator.shared.success()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
    var isFavorited: Bool
    
    var body: some View {
        HStack {
            ActionsView(comic: comic, isFavorited: isFavorited, id: number)
            
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
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}
