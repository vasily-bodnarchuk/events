//
//  EventTableViewBuilder.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/23/21.
//

import Foundation

protocol EventTableViewBuilder: TableViewBuilder {
    typealias Delegate = EventHeaderTableViewCellViewModelDelegate
    func loadViewModels(completion: @escaping (Result<EventTableViewBuilderResult.Result, Error>) -> Void)
    func setEvent(isFavorite: Bool,
                  completion: @escaping (Result<EventTableViewBuilderResult.Result, Error>) -> Void)
}

class EventTableViewBuilderResult {
    enum Result {
        case reloadTableView
        case reload(rowIndex: Int)
    }
}
