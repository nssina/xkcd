//
//  XCNumber.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/28/21.
//

import SwiftUI

struct XCNumberView: View {
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

struct XCNumber_Previews: PreviewProvider {
    static var previews: some View {
        XCNumberView(number: Examples.number)
    }
}
