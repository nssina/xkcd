//
//  FavoriteCell.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/28/21.
//

import SwiftUI

struct FavoriteCell: View {
    var comic: Favorite
    
    var body: some View {
        HStack {
            Image(uiImage: UIImage(data: comic.image!)!)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(comic.title!)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                        .font(.custom(CustomFont.xkcd, size: 20))
                    Spacer()
                    ComicNumberView(number: Int(comic.id))
                }
                
                Text(comic.alt!)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
                    .font(.custom(CustomFont.xkcd, size: 15))
            }
            .padding()
        }
    }
}

struct FavoriteCell_Previews: PreviewProvider {
    static var previews: some View {
        let preview = PersistenceController.preview.container.viewContext
        FavoriteCell(comic: Favorite(context: preview))
    }
}
