//
//  CharactersService.swift
//  RickAndMorty
//
//  Created by Robert Shrestha on 1/7/23.
//

import Foundation

class CharactersService: CharactersServiceProtocol {
    var client: WebServices
    var storage: StorageClient?

    public init(client: WebServices = WebServices.shared, storageClient: StorageClient?) {
        self.client = client
        self.storage = storageClient
    }

    func getCharacters<T:Codable>(resource: Resource<T>) async throws -> T {
       return try await client.load(resource: resource)
    }
}
