//
//  SafariView.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/27/21.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: String
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: URL(string: url)!)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) { }
}

struct SafariView_Previews: PreviewProvider {
    static var previews: some View {
        SafariView(url: "https://shortcut.io/") // =)
    }
}
