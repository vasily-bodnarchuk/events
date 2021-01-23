//
//  EventListServiceImpl.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/20/21.
//

import UIKit

class EventListServiceImpl {
    private let repository: EventListRepository
    private lazy var semaphore = DispatchSemaphore(value: 1)
    
    private var _getAllRequestIsWaitingToBeExecuted = false
    private var getAllRequestKeyword: String?
    init(repository: EventListRepository) { self.repository = repository }
    deinit { semaphore.signal() }
}

extension EventListServiceImpl: EventListService {
    func getAll(searchBy keyword: String?, completion: @escaping (Result<[TableViewCellViewModelInterface], Error>) -> Void) {
        var isItTimeToMakeRequest = false
        DispatchQueue.main.async { completion(.success([ActivityIndicatorTableViewCellViewModel()])) }

        semaphore.wait()
        getAllRequestKeyword = keyword
        if !_getAllRequestIsWaitingToBeExecuted { isItTimeToMakeRequest = true }
        _getAllRequestIsWaitingToBeExecuted = true
        semaphore.signal()

        guard isItTimeToMakeRequest else { return }
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            self?._getAll(completion: completion)
        }
    }

    private func _getAll(completion: @escaping (Result<[TableViewCellViewModelInterface], Error>) -> Void) {
        let keyword: String?
        semaphore.wait()
        _getAllRequestIsWaitingToBeExecuted = false
        keyword = getAllRequestKeyword
        getAllRequestKeyword = nil
        semaphore.signal()

        repository.getAll(searchBy: keyword) { result in
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
