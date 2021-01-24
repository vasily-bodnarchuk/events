//
//  EventTableViewBuilderImpl.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/23/21.
//

import Foundation

class EventTableViewBuilderImpl {
    private(set) weak var delegate: Delegate!
    private let id: Int
    private let title: String
    private let location: String
    private let date: String
    private let imageUrl: URL

    init(id: Int, title: String, location: String, date: String, imageUrl: URL, delegate: Delegate) {
        self.id = id
        self.title = title
        self.location = location
        self.date = date
        self.imageUrl = imageUrl
        self.delegate = delegate
    }
}

extension EventTableViewBuilderImpl: EventTableViewBuilder {
    func getViewModels(completion: @escaping (Result<[TableViewCellViewModelInterface], Error>) -> Void) {
        completion(.success([EventHeaderTableViewCellViewModel(title: title, isFavorited: false, delegate: delegate)]))
    }
}
