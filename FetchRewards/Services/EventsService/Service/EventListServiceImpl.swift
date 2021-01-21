//
//  EventListServiceImpl.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/20/21.
//

import Foundation

class EventListServiceImpl {
    private let repository: EventListRepository
    init(repository: EventListRepository) {
        self.repository = repository
    }
}

extension EventListServiceImpl: EventListService {
    func getAll(completion: @escaping (Result<[TableViewCellViewModelInterface], Error>) -> Void) {
        completion(.success([ActivityIndicatorTableViewCellViewModel()]))
    }

}
