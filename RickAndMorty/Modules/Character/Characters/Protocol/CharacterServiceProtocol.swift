//
//  CharacterServiceProtocol.swift
//  RickAndMorty
//
//  Created by Robert Shrestha on 1/7/23.
//

import Foundation
protocol CharactersServiceProtocol {

    var client: WebServices { get set }
    func getCharacters<T:Codable>(resource: Resource<T>) async throws -> T 
}
