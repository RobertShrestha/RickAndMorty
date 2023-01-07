//  
//  CharacterDetailsServiceProtocol.swift
//  RickAndMorty
//
//  Created by Robert Shrestha on 1/7/23.
//

import Foundation

protocol CharacterDetailsServiceProtocol {
    var client: WebServices { get set }
    func getCharacter<T:Codable>(resource: Resource<T>) async throws -> T 
    func getCharacterBookmark(model: CharacterModel) -> Bool
    func addCharacter(model: CharacterModel)
    func removeCharacter(model: CharacterModel)
}
