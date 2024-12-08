//
//  MockNetworkService.swift
//  RickAndMortyTests
//
//  Created by Khaled on 08/12/2024.
//

import Foundation
@testable import RickAndMorty

final class MockNetworkService: NetworkService {
    
    var data: Data?
    var error: NetworkError?
    var isSuccess = true
    
    func request(endpoint: RickAndMorty.Requestable, completion: @escaping CompletionHandler) {
        if let data = data, isSuccess {
            completion(.success(data))
        } else {
            completion(.failure(error ?? .urlGeneration))
        }
    }
}
