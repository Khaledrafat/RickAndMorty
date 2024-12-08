//
//  CharacterDetailsRepo.swift
//  RickAndMorty
//
//  Created by Khaled on 06/12/2024.
//

import Foundation

final class DefaultCharacterDetailsRepoImp: CharacterDetailsRepo {
    
    private let network: NetworkService
    
    init(network: NetworkService = DefaultNetworkService()) {
        self.network = network
    }
    
    func fetchDetails(id: Int, completion: @escaping (Result<Character, Error>) -> Void) {
        let url = "https://rickandmortyapi.com/api/character/\(id)"
        let request = DefaultRequestable(stringUrl: url, method: .get)
        network.request(endpoint: request) { request in
            switch request {
            case .success(let data):
                do {
                    let user = try JSONDecoder().decode(Character.self, from: data)
                    completion(.success(user))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
