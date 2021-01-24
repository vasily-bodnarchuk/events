//
//  EventListTableViewBuilder.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/23/21.
//

import UIKit

protocol EventListTableViewBuilder: class {
    typealias Delegate = EventTableViewCellViewModelDelegate
    var delegate: Delegate! { get }
    func getViewModelsForTheFirstPage(searchEventsBy keyword: String?,
                                      completion: @escaping (Result<[TableViewCellViewModelInterface], Error>) -> Void)
    func getViewModelsForTheNextPage(completion: @escaping (Result<LoadNextPageResult, Error>) -> Void)
    func reloadViewModels(completion: @escaping (Result<[TableViewCellViewModelInterface], Error>) -> Void)
}

enum LoadNextPageResult {
    case viewModels(_ array: [TableViewCellViewModelInterface])
    case alreadyLoadedLastPage
}
