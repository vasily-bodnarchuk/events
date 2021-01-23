//
//  EventListService.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/20/21.
//

import Foundation

protocol EventListService: class {
    typealias Delegate = EventTableViewCellViewModelDelegate
    func loadAll(searchBy keyword: String?, delegate: Delegate,
                 completion: @escaping (Result<[TableViewCellViewModelInterface], Error>) -> Void)
    func loadNextPageIfPossible(delegate: Delegate, completion: @escaping (Result<LoadNextPageResult, Error>) -> Void)
    func reload(delegate: Delegate, completion: @escaping (Result<[TableViewCellViewModelInterface], Error>) -> Void)
}

enum LoadNextPageResult {
    case viewModels(_ array: [TableViewCellViewModelInterface])
    case alreadyLoadedLastPage
}
