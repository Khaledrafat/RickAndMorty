//
//  HomeRepoImp.swift
//  RickAndMorty
//
//  Created by Khaled on 05/12/2024.
//

import Foundation

final class HomeRepoImp: HomeRepo {
    
    private let network: NetworkService
    
    init(network: NetworkService = DefaultNetworkService()) {
        self.network = network
    }
    
    func fetchCharacters(completion: @escaping (Result<Characters, Error>) -> Void) {
        let url = "https://rickandmortyapi.com/api/character"
        let request = DefaultRequestable(stringUrl: url, method: .get)
        network.request(endpoint: request) { request in
            switch request {
            case .success(let data):
                do {
                    let users = try JSONDecoder().decode(Characters.self, from: data)
                    completion(.success(users))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
