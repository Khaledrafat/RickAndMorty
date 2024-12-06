//
//  Requestable.swift
//  RickAndMorty
//
//  Created by Khaled on 05/12/2024.
//

import Foundation

enum HTTPMethodType: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

protocol Requestable {
    var stringUrl: String { get }
    var method: HTTPMethodType { get }
    var headerParameters: [String: String] { get }
    var queryParameters: [String: Any] { get }
    var bodyParameters: [String: Any] { get }
    
    func getURL() throws -> URL
    func getUrlRequest() throws -> URLRequest
}

class DefaultRequestable: Requestable {
    let stringUrl: String
    let method: HTTPMethodType
    let headerParameters: [String : String]
    let queryParameters: [String : Any]
    let bodyParameters: [String : Any]
    
    //MARK: - INIT
    init(
        stringUrl: String,
        method: HTTPMethodType,
        headerParameters: [String : String] = [:],
        queryParameters: [String : Any] = [:],
        bodyParameters: [String : Any] = [:]
    ) {
        self.stringUrl = stringUrl
        self.method = method
        self.headerParameters = headerParameters
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
    }
    
    //MARK: - Get URL
    func getURL() throws -> URL {
        if queryParameters.count != 0 {
            guard var components = URLComponents(string: stringUrl) else {
                throw NetworkError.urlGeneration
            }

            queryParameters.forEach({components.queryItems?.append(URLQueryItem(name: $0.key, value: "\($0.value)"))})

            guard let url = components.url else {
                throw NetworkError.urlGeneration
            }
            
            return url
        } else {
            guard let url = URL(string: stringUrl) else { throw NetworkError.urlGeneration }
            return url
        }
    }
    
    //MARK: - Get URL Request
    func getUrlRequest() throws -> URLRequest {
        guard let url = try? getURL() else {
            throw NetworkError.urlGeneration
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if bodyParameters.count != 0 {
            let data = try JSONSerialization.data(withJSONObject: bodyParameters, options: [])
            request.httpBody = data
        }
        if headerParameters.count != 0 {
            headerParameters.forEach({request.setValue($0.key, forHTTPHeaderField: "\($0.value)")})
        }
        return request
    }
}
