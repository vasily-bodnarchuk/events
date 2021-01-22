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
       // completion(.success([ActivityIndicatorTableViewCellViewModel()]))
        repository.getAll { result in
            switch result {
            case .failure(let error): DispatchQueue.main.async { completion(.failure(error)) }
            case .success(let value):
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat =  "EEEE, dd MMM yyyy hh:mm a"
                let viewModels = value.events.elements.compactMap { (event) -> EventTableViewCellViewModel? in
                    guard let date = event.datetime_utc.value else { return nil }
                    let dateString = dateFormatter.string(from: date)
                    return .init(id: event.id,
                                 title: event.title,
                                 location: event.venue.display_location,
                                 date: dateString,
                                 imageUrl: URL(string: "https://google.com")!)
                }
                DispatchQueue.main.async { completion(.success(viewModels)) }
            }
        }
    }
}
