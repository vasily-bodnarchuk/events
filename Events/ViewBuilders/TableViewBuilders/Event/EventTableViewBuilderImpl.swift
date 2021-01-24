//
//  EventTableViewBuilderImpl.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/23/21.
//

import UIKit

class EventTableViewBuilderImpl {
    private(set) weak var delegate: Delegate!
    private let event: EventModel

    init(event: EventModel, delegate: Delegate) {
        self.event = event
        self.delegate = delegate
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
}
