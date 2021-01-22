//
//  NetworkServiceImpl.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/21/21.
//

import Foundation

class NetworkServiceImpl {
    private weak var configurationService: ConfigurationService!
    init(configurationService: ConfigurationService) {
        self.configurationService = configurationService
    }
}

extension NetworkServiceImpl: NetworkService {
    func makeRequest<T>(endpoint: Endpoint,
                        httpMethod: HTTPMethod,
                        urlQuery: [String: Any],
                        completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        let session = URLSession.shared
        var urlQuery = urlQuery
        urlQuery["client_id"] = configurationService.clientId
        let path = endpoint.getPath { endpoint in
            switch endpoint {
            case .defaultApi: return configurationService.apiHost
            }
        }
        guard var urlComponents = URLComponents(string: path) else { return }
        urlComponents.queryItems = urlQuery.toURLQueryItems()
        guard let url = urlComponents.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        let task = session.dataTask(with: request) { data, response, error in
            var result: Result<T, Error>!
            defer { completion(result) }
            
            if let error = error {
                result = .failure(AppError.network(type: .nested(error: error)))
                return
            }
            
            if error != nil || data == nil {
                result = .failure(AppError.network(type: .custom(message: "Client error!")))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                result = .failure(AppError.network(type: .custom(message: "Server error!")))
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                result = .failure(AppError.network(type: .custom(message: "Wrong MIME type!")))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                result = .success(try T(from: json) { _ in })
            } catch let error {
                result = .failure(AppError.network(type: .nested(error: error)))
            }
        }
        
        task.resume()
    }
}
