//
//  Constants.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/26/21.
//

import Foundation
import SwiftUI

enum SFSymbols {
    static let comics = "rectangle.3.offgrid.bubble.left.fill"
    static let search = "magnifyingglass"
    static let favorite = "star"
    static let favorited = "star.fill"
    static let send = "paperplane"
    static let arrow = "arrow.forward"
}

enum CustomFont {
    static let xkcd = "xkcd"
}

enum Examples {
    static let url = "https://shortcut.io/" // =)
    static var sampleComic = ComicModel(id: 0, publishedAt: "", news: "", safeTitle: "", title: "", transcript: "", alt: "", sourceURL: "", explainURL: "", interactiveURL: "", imgs: [ComicImageModel(height: 0, width: 0, ratio: 0.0, sourceURL: "", size: "")])
    static let number = 0
    static let bool = false
    static let string = "EMPTY"
}
