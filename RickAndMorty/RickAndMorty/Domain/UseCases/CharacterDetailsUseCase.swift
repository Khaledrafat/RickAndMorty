//
//  CHaracterDetailsUseCase.swift
//  RickAndMorty
//
//  Created by Khaled on 06/12/2024.
//

import Foundation

protocol CharacterDetailsUseCase {
    func fetchCharacterDetails(
        id: Int,
        completion: @escaping (Result<Character, Error>) -> Void
    )
}

//MARK: - DefaultCharacterDetailsUseCase
final class DefaultCharacterDetailsUseCase: CharacterDetailsUseCase {
    
    private var detailsRepo: CharacterDetailsRepo
    
    init(detailsRepo: CharacterDetailsRepo) {
        self.detailsRepo = detailsRepo
    }
    
    func fetchCharacterDetails(id: Int, completion: @escaping (Result<Character, Error>) -> Void) {
        detailsRepo.fetchDetails(id: id, completion: completion)
    }
    
}
