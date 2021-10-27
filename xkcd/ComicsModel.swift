//
//  ComicModel.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/26/21.
//

import Foundation

// MARK: - ComicModel
struct ComicModel: Codable, Identifiable, Comparable, Hashable {
    let id: Int
    let publishedAt, news, safeTitle, title: String
    let transcript, alt: String
    let sourceURL, explainURL: String
    let interactiveURL: String?
    let imgs: [ComicImageModel]
    
    static func < (lhs: ComicModel, rhs: ComicModel) -> Bool {
        lhs.id < rhs.id
    }
    
    
    static func == (lhs: ComicModel, rhs: ComicModel) -> Bool {
        lhs.id == rhs.id
    }

    enum CodingKeys: String, CodingKey {
        case id, publishedAt, news, safeTitle, title, transcript, alt
        case sourceURL = "sourceUrl"
        case explainURL = "explainUrl"
        case interactiveURL = "interactiveUrl"
        case imgs
    }
}

// MARK: - ComicImageModel
struct ComicImageModel: Codable, Hashable {
    let height, width: Int
    let ratio: Double
    let sourceURL: String
    let size: String

    enum CodingKeys: String, CodingKey {
        case height, width, ratio
        case sourceURL = "sourceUrl"
        case size
    }
}

typealias ComicsModel = [ComicModel]
