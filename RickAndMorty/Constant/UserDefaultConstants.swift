//
//  UserDefaultConstants.swift
//  RickAndMorty
//
//  Created by Robert Shrestha on 1/7/23.
//

import Foundation
@propertyWrapper
struct UserDefault<T> {
    let key: String
    var defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
struct UserDefaultsConstants {
    @UserDefault(Constants.UserDefaults.bookmarkedCharacters.value, defaultValue: Data())
    static var bookmarkedCharacters: Data
}
