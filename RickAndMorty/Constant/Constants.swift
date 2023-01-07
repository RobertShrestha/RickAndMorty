//
//  Constants.swift
//  RickAndMorty
//
//  Created by Robert Shrestha on 1/7/23.
//

import Foundation


struct Constants {
    enum UserDefaults: String {
        case idToken
        case bookmarkedCharacters
        var value: String {
            return self.rawValue
        }
    }
    static let noInternetConnection = "No network connection. Please connect to the internet."
    static let parsingError = "Something went wrong when parsing the data."
    static let cancel = "Cancel"
    static let labelSkip = "Skip for now"
    static let back = "Back"
    static let labelOk = "Ok"
    static let perPage = 20
}
