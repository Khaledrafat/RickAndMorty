//
//  Character.swift
//  RickAndMorty
//
//  Created by Khaled on 05/12/2024.
//

import Foundation
import SwiftUI

// MARK: - Characters
struct Characters: Codable {
    let info: Info?
    var results: [Character]?
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int?
    let next: String?
    let prev: String?
}

// MARK: - Character
struct Character: Codable, Equatable {
    static func == (lhs: Character, rhs: Character) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int?
    let name: String?
    let status: Filter?
    let species: String?
    let type: String?
    let gender: String?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}

//MARK: - Filter
enum Filter: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    var color: Color {
        switch self {
        case .alive:
            return Color.cyan
        case .dead:
            return Color.red
        case .unknown:
            return Color.clear
        }
    }
}

enum CharacterFilter: String {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    case all = "all"
}

//MARK: - Filter Characters
struct FilteredCharacters {
    var characters: [Character]?
    var filter: CharacterFilter = .all
}
