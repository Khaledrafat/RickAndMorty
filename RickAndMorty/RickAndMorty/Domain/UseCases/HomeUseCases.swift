//
//  HomeUseCases.swift
//  RickAndMorty
//
//  Created by Khaled on 05/12/2024.
//

import Foundation

protocol HomeUseCases {
    func fetchCharacters(
        completion: @escaping (Result<Characters, Error>) -> Void
    )
    
    func filter(type: Filter, characters: [Character]) -> [Character]
}

//MARK: - DefaultHomeUseCases
final class DefaultHomeUseCases: HomeUseCases {
    
    private var homeRepo: HomeRepo
    
    init(homeRepo: HomeRepo) {
        self.homeRepo = homeRepo
    }
    
    //MARK: - Fetch Characters
    func fetchCharacters(completion: @escaping (Result<Characters, Error>) -> Void) {
        homeRepo.fetchCharacters(completion: completion)
    }
    
    //MARK: - Filter Data
    func filter(type: Filter, characters: [Character]) -> [Character] {
        return characters.filter({ $0.status ?? .unknown == type })
    }
}
