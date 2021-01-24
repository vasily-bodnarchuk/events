//
//  EventListTableViewBuilderImpl.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/23/21.
//

import UIKit

class EventListTableViewBuilderImpl: EventListTableViewBuilder {
    private(set) weak var delegate: Delegate!
    private let eventListService: EventListService
    private var _getAllRequestIsWaitingToBeExecuted = AtomicValue(value: false)
    private var getAllRequestKeyword = AtomicValue<String?>(value: nil)
    private var hasNextPage = AtomicValue<Int?>(value: 1)

    init(eventListService: EventListService, delegate: Delegate) {
        self.eventListService = eventListService
        self.delegate = delegate
    }
}

extension EventListTableViewBuilderImpl {
    func getViewModelsForTheFirstPage(searchEventsBy keyword: String?,
                                      completion: @escaping (Result<[TableViewCellViewModelInterface], Error>) -> Void) {
        hasNextPage.waitSet(value: 1)
        getAllRequestKeyword.waitSet(value: keyword)
        completion(.success([ActivityIndicatorTableViewCellViewModel()]))
        reloadViewModels(completion: completion)
    }

    private func _loadAll(page: Int,
                          completion: @escaping (Result<[TableViewCellViewModelInterface], Error>) -> Void) {
        let keyword: String? = getAllRequestKeyword.waitGet().notQueueSafeValue
        _getAllRequestIsWaitingToBeExecuted.waitSet(value: false)

        eventListService.load(searchBy: keyword, page: page) { result in
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
                let events = value.events.elements
                var viewModels = events.enumerated().flatMap { (index, event) -> [TableViewCellViewModelInterface] in
                    guard let date = event.datetime_utc.value,
                          let imageUrl = event.performers.elements.first?.image else { return [] }
                    let dateString = dateFormatter.string(from: date)
                    var result: [TableViewCellViewModelInterface] = [
                        EventTableViewCellViewModel(id: event.id,
                                                    title: event.title,
                                                    location: event.venue.display_location,
                                                    date: dateString,
                                                    imageUrl: imageUrl,
                                                    delegate: self.delegate)
                    ]
                    switch index {
                    case 0: break
                    default:
                        result.insert(SeparatorTableViewCellViewModel(separatorViewColor: UIColor(r: 235, g: 235, b: 235),
                                                                      separatorViewHeight: 1,
                                                                      separatorViewEdgeInsets: .init(top: 24, left: 16, bottom: 24, right: 0)), at: 0)
                    }
                    return result
                }
                if value.meta.page == 1 {
                    viewModels.insert(VerticalSpacingTableViewCellViewModel(height: verticalSpacing), at: 0)
                }
                DispatchQueue.main.async { completion(.success(viewModels)) }
            }
        }
    }

    func getViewModelsForTheNextPage(completion: @escaping (Result<LoadNextPageResult, Error>) -> Void) {
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

    func reloadViewModels(completion: @escaping (Result<[TableViewCellViewModelInterface], Error>) -> Void) {
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
