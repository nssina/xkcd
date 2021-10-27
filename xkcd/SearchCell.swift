//
//  SearchCell.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/27/21.
//

import SwiftUI

struct SearchCell: View {
    var comic: ComicModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(comic.title)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                        .font(.custom(CustomFont.xkcd, size: 20))
                    Spacer()
                    ComicNumberView(number: comic.id)
                }
                
                Text(comic.alt)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
                    .font(.custom(CustomFont.xkcd, size: 15))
            }
            .padding()
        }
    }
}

struct SearchCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchCell(comic: ComicModel(id: 0, publishedAt: "", news: "", safeTitle: "", title: "", transcript: "", alt: "", sourceURL: "", explainURL: "", interactiveURL: "", imgs: [ComicImageModel(height: 0, width: 0, ratio: 0.0, sourceURL: "", size: "")]))
    }
}
