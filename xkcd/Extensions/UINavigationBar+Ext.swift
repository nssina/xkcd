//
//  UINavigationBar+Ext.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/27/21.
//

import UIKit

extension UINavigationBar {
    func setFont(_ name: String, largeSize: CGFloat, inlineSize: CGFloat) {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: name, size: largeSize)!]
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: name, size: inlineSize)!]
    }
}
