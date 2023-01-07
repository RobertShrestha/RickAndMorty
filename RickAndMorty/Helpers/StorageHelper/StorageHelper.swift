//
//  StorageHelper.swift
//  RickAndMorty
//
//  Created by Robert Shrestha on 1/7/23.
//

import Foundation

protocol Storage {
    var characters: [CharacterModel] {get set}
    mutating func load() -> [CharacterModel]
    mutating func remove(character: CharacterModel)
    mutating func save(character: CharacterModel)
    func isBookmarked(character: CharacterModel) -> Bool
}

struct UserDefaultStorage: Storage {

    var characters: [CharacterModel]


    func load() -> [CharacterModel] {
        let bookmarkedProducts = UserDefaultsConstants.bookmarkedCharacters.decoded() as [CharacterModel]
        return bookmarkedProducts
    }

    mutating func remove(character: CharacterModel) {
        let bookmarkedProducts = UserDefaultsConstants.bookmarkedCharacters.decoded() as [CharacterModel]
        let filteredProducts = bookmarkedProducts.filter({$0.id != character.id})
        UserDefaultsConstants.bookmarkedCharacters = filteredProducts.toData() ?? Data()
    }

    mutating func save(character: CharacterModel) {

        if UserDefaultsConstants.bookmarkedCharacters == Data() {
            characters = []
        }else {
            characters = UserDefaultsConstants.bookmarkedCharacters.decoded() as [CharacterModel]
        }
        characters.append(character)
        UserDefaultsConstants.bookmarkedCharacters = characters.toData() ?? Data()
    }
    func isBookmarked(character: CharacterModel) -> Bool {
        if UserDefaultsConstants.bookmarkedCharacters == Data() {
            return false
        } else {
            let bookmarkedProducts = UserDefaultsConstants.bookmarkedCharacters.decoded() as [CharacterModel]
            return bookmarkedProducts.contains(character)
        }
    }

}

struct StorageClient {
    var storage: Storage

    init(storage: Storage) {
        self.storage = storage
    }

    mutating func loadCharacters() -> [CharacterModel] {
        return storage.load()
    }
    mutating func addCharacter(with character: CharacterModel) {
        return storage.save(character: character)
    }
    mutating func removeCharacter(with character: CharacterModel) {
        return storage.remove(character: character)
    }
    func isBookmarked(with character: CharacterModel) -> Bool {
        return storage.isBookmarked(character: character)
    }
}
