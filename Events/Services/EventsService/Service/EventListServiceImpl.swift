//
//  EventListServiceImpl.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/20/21.
//

import UIKit

class EventListServiceImpl {
    private let repository: EventListRepository
    private var _getAllRequestIsWaitingToBeExecuted = AtomicValue(value: false)
    private var getAllRequestKeyword = AtomicValue<String?>(value: nil)
    private var hasNextPage = AtomicValue<Int?>(value: 1)

    init(repository: EventListRepository) { self.repository = repository }
}

extension EventListServiceImpl: EventListService {

    func loadAll(searchBy keyword: String?, completion: @escaping (Result<[TableViewCellViewModelInterface], Error>) -> Void) {
        hasNextPage.waitSet(value: 1)
        getAllRequestKeyword.waitSet(value: keyword)
        completion(.success([ActivityIndicatorTableViewCellViewModel()]))
        reload(completion: completion)
    }

    private func _loadAll(page: Int, completion: @escaping (Result<[TableViewCellViewModelInterface], Error>) -> Void) {
        let keyword: String? = getAllRequestKeyword.waitGet().notQueueSafeValue
        _getAllRequestIsWaitingToBeExecuted.waitSet(value: false)

        repository._loadAll(searchBy: keyword, page: page) { result in
            switch result {
            case .failure(let error): DispatchQueue.main.async { completion(.failure(error)) }
            case .success(let value):
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat =  "EEEE, dd MMM yyyy hh:mm a"
                let verticalSpacing: CGFloat = 24
                if (value.meta.page * value.meta.per_page) < value.meta.total {
                    self.hasNextPage.waitSet(value: value.meta.page + 1)
                } else {
                    self.hasNextPage.waitSet(value: nil)
                }
                var viewModels = value.events.elements.flatMap { (event) -> [TableViewCellViewModelInterface] in
                    guard let date = event.datetime_utc.value,
                          let imageUrl = event.performers.elements.first?.image else { return [] }
                    let dateString = dateFormatter.string(from: date)
                    return [
                        EventTableViewCellViewModel.init(id: event.id,
                                                         title: event.title,
                                                         location: event.venue.display_location,
                                                         date: dateString,
                                                         imageUrl: imageUrl),
                        VerticalSpacingTableViewCellViewModel(height: verticalSpacing)
                    ]
                }
                if value.meta.page == 1 {
                    viewModels.insert(VerticalSpacingTableViewCellViewModel(height: verticalSpacing), at: 0)
                }
                DispatchQueue.main.async { completion(.success(viewModels)) }
            }
        }
    }

    func loadNextPageIfPossible(completion: @escaping (Result<LoadNextPageResult, Error>) -> Void) {
        guard let page = hasNextPage.waitGet().notQueueSafeValue else {
            DispatchQueue.main.async { completion(.success(.alreadyLoadedLastPage)) }
            return
        }
        _loadAll(page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error): completion(.failure(error))
                case .success(let viewModels): completion(.success(.viewModels(viewModels)))
                }
            }
        }
    }

    func reload(completion: @escaping (Result<[TableViewCellViewModelInterface], Error>) -> Void) {
        hasNextPage.waitSet(value: 1)
        var isItTimeToMakeRequest = false
        _getAllRequestIsWaitingToBeExecuted.waitSet { isWaiting -> Bool in
            if !isWaiting { isItTimeToMakeRequest = true }
            return true
        }

        guard isItTimeToMakeRequest else { return }
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            self?._loadAll(page: 1, completion: completion)
        }
    }
}
