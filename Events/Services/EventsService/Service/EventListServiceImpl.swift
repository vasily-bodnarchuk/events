//
//  EventListServiceImpl.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/20/21.
//

import UIKit

class EventListServiceImpl {
    private let repository: EventListRepository
    init(repository: EventListRepository) {
        self.repository = repository
    }
}

extension EventListServiceImpl: EventListService {
    func getAll(completion: @escaping (Result<[TableViewCellViewModelInterface], Error>) -> Void) {
        repository.getAll { result in
            switch result {
            case .failure(let error): DispatchQueue.main.async { completion(.failure(error)) }
            case .success(let value):
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat =  "EEEE, dd MMM yyyy hh:mm a"
                let verticalSpacing: CGFloat = 24
                var viewModels = value.events.elements.flatMap { (event) -> [TableViewCellViewModelInterface] in
                    guard let date = event.datetime_utc.value,
                          let imageUrl = event.performers.elements.first?.image else { return [] }
                    let dateString = dateFormatter.string(from: date)
                    return [
                        VerticalSpacingTableViewCellViewModel(height: verticalSpacing),
                        EventTableViewCellViewModel.init(id: event.id,
                                                         title: event.title,
                                                         location: event.venue.display_location,
                                                         date: dateString,
                                                         imageUrl: imageUrl)
                    ]
                }
                viewModels.append(VerticalSpacingTableViewCellViewModel(height: verticalSpacing))
                DispatchQueue.main.async { completion(.success(viewModels)) }
            }
        }
    }
}
