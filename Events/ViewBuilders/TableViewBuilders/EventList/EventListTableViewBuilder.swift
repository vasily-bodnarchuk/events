//
//  EventListTableViewBuilder.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/23/21.
//

import UIKit

protocol EventListTableViewBuilder: class {
    typealias Delegate = EventTableViewCellViewModelDelegate
    var tableView: ViewModelCellBasedTableView! { get set }
    var viewModels: [TableViewCellViewModelInterface] { get }
    func loadViewModelsForTheFirstPage(searchEventsBy keyword: String?,
                                       completion: @escaping (EventListTableViewBuilderResult.FirstPage) -> Void)
    func loadViewModelsForTheNextPage(completion: @escaping (Result<EventListTableViewBuilderResult.NextPage, Error>) -> Void)
    func reloadViewModels(completion: @escaping (Result<Void, Error>) -> Void)
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
