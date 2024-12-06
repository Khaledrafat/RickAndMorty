//
//  HomeRepo.swift
//  RickAndMorty
//
//  Created by Khaled on 05/12/2024.
//

import Foundation

protocol HomeRepo {
    func fetchCharacters(
        completion: @escaping (Result<Characters, Error>) -> Void
    )
}