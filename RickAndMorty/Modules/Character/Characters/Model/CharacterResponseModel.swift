//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Robert Shrestha on 1/7/23.
//

import Foundation
struct CharacterResponseModel: Codable {
    let info: Info?
    let results: [CharacterModel]?
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int?
    let next: String?
    let prev: String?
}

// MARK: - Result
struct CharacterModel: Codable {
    let id: Int?
    let name: String?
    let status: Status?
    let species: String?
    let type: String?
    let gender: Gender?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
    case genderLess = "Genderless"
}

// MARK: - Location
struct Location: Codable {
    let name: String?
    let url: String?
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
extension CharacterModel: Equatable {
    static func == (lhs: CharacterModel, rhs: CharacterModel) -> Bool {
        lhs.id == rhs.id
    }
}
