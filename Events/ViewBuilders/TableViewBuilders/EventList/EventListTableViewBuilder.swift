//
//  EventListTableViewBuilder.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/23/21.
//

import UIKit

protocol EventListTableViewBuilder: TableViewBuilder {
    typealias Delegate = EventTableViewCellViewModelDelegate
    func loadViewModelsForTheFirstPage(searchEventsBy keyword: String?,
                                       completion: @escaping (EventListTableViewBuilderResult.FirstPage) -> Void)
    func loadViewModelsForTheNextPage(completion: @escaping (Result<EventListTableViewBuilderResult.NextPage, Error>) -> Void)
    func reloadViewModels(completion: @escaping (Result<EventListTableViewBuilderResult.FirstPage, Error>) -> Void)
}

class EventListTableViewBuilderResult {
    enum NextPage {
        case addedMoreViewModels(count: Int)
        case alreadyLoadedLastPage
    }

    enum FirstPage {
        case reloadTableView(properties: [TableViewProperty])
    }
}
