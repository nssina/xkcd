//
//  XCImage.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/28/21.
//

import SwiftUI

struct XCImageView: View {
    @GestureState private var scale: CGFloat = 1.0
    var url: String
    
    var body: some View {
        AsyncImage(url).scaleEffect(scale)
            .gesture(MagnificationGesture().updating($scale, body: { newValue, scale, _ in
                scale = newValue
            }))
    }
}

struct XCImage_Previews: PreviewProvider {
    static var previews: some View {
        XCImageView(url: Examples.url)
    }
}
