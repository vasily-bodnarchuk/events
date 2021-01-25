//
//  EventTableViewBuilderImpl.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/23/21.
//

import UIKit

class EventTableViewBuilderImpl {
    private(set) weak var delegate: Delegate!
    private var event: EventModel
    private var eventService: EventService!

    init(event: EventModel, eventService: EventService, delegate: Delegate) {
        self.event = event
        self.delegate = delegate
        self.eventService = eventService
    }
}

extension EventTableViewBuilderImpl: EventTableViewBuilder {
    func getViewModels(completion: @escaping (Result<[TableViewCellViewModelInterface], Error>) -> Void) {
        completion(.success([
            EventHeaderTableViewCellViewModel(title: event.title,
                                              isFavorited: event.isFavorite,
                                              delegate: delegate),
            SeparatorTableViewCellViewModel(separatorViewColor: .lightGray,
                                            separatorViewHeight: 2,
                                            separatorViewEdgeInsets: .init(top: 20, left: 16, bottom: 20, right: 16)),
            MaxWidthImageTableViewCellViewModel(imageURL: event.imageUrl),
            VerticalSpacingTableViewCellViewModel(height: 20),
            LabelTableViewCellViewModel(text: event.visibleDate, configureLabel: { label in
                label.font = .systemFont(ofSize: 19, weight: .semibold)
            }),
            VerticalSpacingTableViewCellViewModel(height: 16),
            LabelTableViewCellViewModel(text: event.location, configureLabel: { label in
                label.font = .systemFont(ofSize: 17, weight: .regular)
                label.textColor = .lightGray
            })
        ]))
    }

    func setEvent(isFavorite: Bool,
                  completion: @escaping (Result<(viewModelToReload: TableViewCellViewModelInterface, atIndex: Int), Error>) -> Void) {
        eventService.isFavorite = isFavorite
        event = .init(id: event.id, title: event.title,
                      location: event.location,
                      date: event.date,
                      visibleDate: event.visibleDate,
                      imageUrl: event.imageUrl,
                      isFavorite: isFavorite)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            completion(.success(((EventHeaderTableViewCellViewModel(title: self.event.title,
                                                                    isFavorited: self.event.isFavorite,
                                                                    delegate: self.delegate)), 0)))
        }
    }
}
