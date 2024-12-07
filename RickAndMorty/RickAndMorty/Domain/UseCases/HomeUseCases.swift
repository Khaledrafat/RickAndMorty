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
    
    func filterCharacters(
        with filter: CharacterFilter,
        characters: [Character]
    ) -> [Character]
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
    
    //MARK: - Filter Characters
    func filterCharacters(with filter: CharacterFilter, characters: [Character]) -> [Character] {
        let result = characters.filter { character in
            switch filter {
            case .alive, .dead, .unknown:
                if (character.status?.rawValue) ?? "" == filter.rawValue {
                    return true
                } else {
                    return false
                }
                
            case .all:
                return true
            }
        }
        
        return result
    }
}
