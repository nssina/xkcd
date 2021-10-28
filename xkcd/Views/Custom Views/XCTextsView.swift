//
//  XCTextsView.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/28/21.
//

import SwiftUI

struct XCTextsView: View {
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

struct XCTextsView_Previews: PreviewProvider {
    static var previews: some View {
        XCTextsView(title: Examples.string, desc: Examples.string)
    }
}
