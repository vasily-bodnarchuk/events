//
//  NetworkService.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/21/21.
//

import Foundation

protocol NetworkService: class {
    func makeRequest<T>(endpoint: Endpoint,
                        httpMethod: HTTPMethod,
                        urlQuery: [String: Any],
                        completion: @escaping (Result<T, Error>) -> Void) where T: Decodable
}

extension NetworkService {
    func makeRequest<T>(endpoint: Endpoint,
                        httpMethod: HTTPMethod = .get,
                        urlQuery: [String: Any] = [:],
                        completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        makeRequest(endpoint: endpoint, httpMethod: httpMethod, urlQuery: urlQuery, completion: completion)
    }
}
