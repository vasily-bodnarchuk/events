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
        networkService.makeRequest(endpoint: .defaultApi(.v2(.events))) { (response: Result<EventListJSONModel, Error>) in
            switch response {
            case .failure(let error): print(error.localizedDescription)
            case .success(let events): print(events.events.elements)
            }
        }
    }
}
