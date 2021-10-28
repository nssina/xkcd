//
//  XCActionView.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/28/21.
//

import SwiftUI

struct XCActionView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isShowingShareSheet = false
    private let network = NetworkManager.shared
    
    var comic: ComicModel
    @State var isFavorited: Bool
    var id: Int
    
    var body: some View {
        HStack(spacing: 25) {
            Button {
                if !isFavorited {
                    save(comic: comic)
                } else {
                    HapticGenerator.shared.warning()
                }
            } label: {
                Image(systemName: isFavorited ? SFSymbols.favorited : SFSymbols.favorite)
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
                let imageURL = comic.imgs[0].sourceURL
                ShareSheet(activityItems: [UIImage(data: network.getImageData(imageURL)) ?? UIImage(), comic.title, comic.alt])
            }
        }
    }
    
    private func save(comic: ComicModel) {
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
                isFavorited.toggle()
                HapticGenerator.shared.success()
            } catch {
                // This error should handle for the application release.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct XCActionView_Previews: PreviewProvider {
    static var previews: some View {
        XCActionView(comic: Examples.sampleComic, isFavorited: Examples.bool, id: Examples.number)
    }
}
