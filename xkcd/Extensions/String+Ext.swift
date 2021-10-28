//
//  String+Ext.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/28/21.
//

import Foundation

extension String {
    func changeFormat(inputFormat: String = "yyyy-MM-dd'T'HH:mm:ss.sssZ", outputFormat: String = "MMM d, yyyy") -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = outputFormat
            return outputFormatter.string(from: date)
        } else {
            return self
        }
    }
}
