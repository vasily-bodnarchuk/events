//
//  EventListServiceImpl.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/20/21.
//

import UIKit

class EventListServiceImpl {
    private let repository: EventListRepository
    private weak var dbService: DBService!
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "EEEE, dd MMM yyyy hh:mm a"
        return dateFormatter
    }()

    init(repository: EventListRepository, dbService: DBService) {
        self.repository = repository
        self.dbService = dbService
    }
}

extension EventListServiceImpl: EventListService {

    func load(searchBy keyword: String?, page: Int,
              completion: @escaping (Result<EventListModel, Error>) -> Void) {
        repository.load(searchBy: keyword, page: page) { [weak self] result in
            switch result {
            case .failure(let error): completion(.failure(error))
            case .success(let eventList):
                guard let self = self  else { return }

                let meta = MetaModel(total: eventList.meta.total,
                                     page: eventList.meta.page,
                                     perPage: eventList.meta.per_page)

                let favoriteEventIds = self.getIdOfFavoriteItems()

                let events = eventList.events.elements.compactMap { event -> EventModel? in
                    guard let imageUrl = event.performers.elements.first?.image,
                          let date = event.datetime_utc.value else { return nil }
                    return .init(id: event.id,
                                 title: event.title,
                                 location: event.venue.display_location,
                                 date: date,
                                 visibleDate: self.dateFormatter.string(from: date),
                                 imageUrl: imageUrl,
                                 isFavorite: favoriteEventIds.contains(event.id))
                }
                completion(.success(.init(events: events, meta: meta)))
            }
        }
    }
}

extension EventListServiceImpl {
    func getIdOfFavoriteItems() -> [Int] {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        var favoriteEventIds = [Int]()
        self.dbService.action(value: .favoritedEvents(action: .get(completion: { ids in
            if let ids = ids { favoriteEventIds = ids }
            dispatchGroup.leave()
        })))
        dispatchGroup.wait()
        return favoriteEventIds
    }
}
