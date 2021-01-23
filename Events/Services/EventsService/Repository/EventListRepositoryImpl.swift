//
//  EventListRepositoryImpl.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/20/21.
//

import Foundation

class EventListRepositoryImpl: EventListRepository {
    private weak var networkService: NetworkService!
    init (networkService: NetworkService) {
        self.networkService = networkService
    }

    func getAll(searchBy keyword: String?, completion: @escaping (Result<EventListJSONModel, Error>) -> Void) {
        var urlQuery = [String: Any]()
        if let keyword  = keyword, !keyword.isEmpty { urlQuery["q"] = keyword.replacingOccurrences(of: " ", with: "+") }
        networkService.makeRequest(endpoint: .defaultApi(.v2(.events)),
                                   urlQuery: urlQuery) { (response: Result<EventListJSONModel, Error>) in
            switch response {
            case .failure(let error): completion(.failure(error))
            case .success(let value): completion(.success(value))
            }
        }
    }
}
