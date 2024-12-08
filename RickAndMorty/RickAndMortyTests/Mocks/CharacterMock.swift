//
//  CharacterMock.swift
//  RickAndMortyTests
//
//  Created by Khaled on 08/12/2024.
//

import Foundation
@testable import RickAndMorty

extension Character {
    static func mock(id: Int, name: String) -> Character {
        return Character(
            id: id,
            name: name,
            status: nil,
            species: nil,
            type: nil,
            gender: nil,
            origin: nil,
            location: nil,
            image: nil,
            episode: nil,
            url: nil,
            created: nil)
    }
    
    static func mockStatus(id: Int, name: String, status: Filter) -> Character {
        return Character(
            id: id,
            name: name,
            status: status,
            species: nil,
            type: nil,
            gender: nil,
            origin: nil,
            location: nil,
            image: nil,
            episode: nil,
            url: nil,
            created: nil)
    }
}
