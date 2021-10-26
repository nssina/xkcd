//
//  ImageLoaderAndCache.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/26/21.
//

import Foundation
import SwiftUI

struct AsyncImage: View {
    
    @ObservedObject var imageLoader: ImageHandler
    
    init(_ url: String) { imageLoader = ImageHandler(imageURL: url) }
    
    var body: some View {
        Image(uiImage: UIImage(data: self.imageLoader.imageData) ?? UIImage(named: "Placeholder")!)
            .resizable()
            .scaledToFill()
            .cornerRadius(8)
    }
}

class ImageHandler: ObservableObject {
    
    @Published var imageData = Data()
    
    init(imageURL: String) {
        let cache = URLCache.shared
        let request = URLRequest(url: URL(string: imageURL)!, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 60.0)
        
        if let data = cache.cachedResponse(for: request)?.data {
            self.imageData = data
        } else {
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        self.imageData = data
                    }
                }
            }).resume()
        }
    }
}
