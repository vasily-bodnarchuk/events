//
//  EventListTableViewBuilder.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/23/21.
//

import UIKit

protocol EventListTableViewBuilder {
    typealias Delegate = EventTableViewCellViewModelDelegate
    func getViewModelsForTheFirstPage(searchEventsBy keyword: String?, delegate: Delegate,
                                      completion: @escaping (Result<[TableViewCellViewModelInterface], Error>) -> Void)
    func getViewModelsForTheNextPage(delegate: Delegate, completion: @escaping (Result<LoadNextPageResult, Error>) -> Void)
    func reloadViewModels(delegate: Delegate, completion: @escaping (Result<[TableViewCellViewModelInterface], Error>) -> Void)
}

enum LoadNextPageResult {
    case viewModels(_ array: [TableViewCellViewModelInterface])
    case alreadyLoadedLastPage
}
