//
//  Character.swift
//  RickAndMorty
//
//  Created by Khaled on 05/12/2024.
//

import Foundation

// MARK: - Ss
struct Characters: Codable {
    let info: Info?
    let results: [Character]?
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int?
    let next: String?
    let prev: String?
}

// MARK: - Result
struct Character: Codable {
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
}
