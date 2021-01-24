//
//  EventListTableViewBuilder.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/23/21.
//

import UIKit

protocol EventListTableViewBuilder: class {
    typealias Delegate = EventTableViewCellViewModelDelegate
    func getViewModelsForTheFirstPage(searchEventsBy keyword: String?,
                                      completion: @escaping (Result<EventListTableViewBuilderResult.FirstPage, Error>) -> Void)
    func getViewModelsForTheNextPage(completion: @escaping (Result<EventListTableViewBuilderResult.NextPage, Error>) -> Void)
    func reloadViewModels(completion: @escaping (Result<[TableViewCellViewModelInterface], Error>) -> Void)
}

class EventListTableViewBuilderResult {
    enum NextPage {
        case viewModels(_ array: [TableViewCellViewModelInterface])
        case alreadyLoadedLastPage
    }

    enum FirstPage {
        case viewModels(_ array: [TableViewCellViewModelInterface], tableViewProperties: [TableViewProperty])
    }
}
