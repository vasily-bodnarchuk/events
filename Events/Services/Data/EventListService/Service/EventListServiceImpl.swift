//
//  EventListServiceImpl.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/20/21.
//

import Foundation

class EventListServiceImpl {
    private let repository: EventListRepository
    init(repository: EventListRepository) { self.repository = repository }
}

extension EventListServiceImpl: EventListService {

    func load(searchBy keyword: String?, page: Int,
              completion: @escaping (Result<EventListJSONModel, Error>) -> Void) {
        repository.load(searchBy: keyword, page: page, completion: completion)
    }
}
