//
//  CharacterDetailsRepo.swift
//  RickAndMorty
//
//  Created by Khaled on 06/12/2024.
//

import Foundation

protocol CharacterDetailsRepo {
    func fetchDetails(
        id: Int,
        completion: @escaping (Result<Character, Error>) -> Void
    )
}
