//  
//  CharacterDetailsService.swift
//  RickAndMorty
//
//  Created by Robert Shrestha on 1/7/23.
//

import Foundation
class CharacterDetailsService: CharacterDetailsServiceProtocol {
    func getCharacter<T:Codable>(resource: Resource<T>) async throws -> T {
        return try await client.load(resource: resource)
    }

    var client: WebServices
    var storage: StorageClient

    public init(client: WebServices = WebServices.shared, storageClient: StorageClient = StorageClient(storage: UserDefaultStorage(characters: []))) {
        self.client = client
        self.storage = storageClient
    }
    func addCharacter(model: CharacterModel) {
        self.storage.addCharacter(with: model)
    }
    func removeCharacter(model: CharacterModel) {
        self.storage.removeCharacter(with: model)
    }
    func getCharacterBookmark(model: CharacterModel) -> Bool {
        self.storage.isBookmarked(with: model)
    }

}
