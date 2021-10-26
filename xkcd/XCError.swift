//
//  XCError.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/26/21.
//

import Foundation

// You may be asking what does XCError means? It's the abbreviation of the app name. xkcd error. :)
enum XCError: String, Error {
    case invalidURL = "This url created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this user. Please try again."
}
