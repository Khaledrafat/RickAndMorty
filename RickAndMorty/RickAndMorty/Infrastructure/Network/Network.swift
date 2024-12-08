//
//  Network.swift
//  RickAndMorty
//
//  Created by Khaled on 05/12/2024.
//

import Foundation

enum NetworkError: Error {
    case error(statusCode: Int, data: Data?, message: String)
    case urlGeneration
    case unexpectedError
}

protocol NetworkService {
    typealias CompletionHandler = (Result<Data, NetworkError>) -> Void
    
    func request(endpoint: Requestable, completion: @escaping CompletionHandler)
}

final class DefaultNetworkService: NetworkService {
    
    func request(endpoint: Requestable, completion: @escaping CompletionHandler) {
        guard let request = try? endpoint.getUrlRequest() else {
            completion(.failure(.urlGeneration))
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error, let response = response as? HTTPURLResponse {
                completion(.failure(.error(
                    statusCode:response.statusCode,
                    data: data,
                    message: error.localizedDescription
                )))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(.unexpectedError))
            }
        }
        
        task.resume()
    }
}
