//
//  EventListService.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/20/21.
//

import Foundation

protocol EventListService: class {
    func loadAll(searchBy keyword: String?, completion: @escaping (Result<[TableViewCellViewModelInterface], Error>) -> Void)
    func loadNextPageIfPossible(completion: @escaping (Result<LoadNextPageResult, Error>) -> Void)
}

enum LoadNextPageResult {
    case viewModels(_ array: [TableViewCellViewModelInterface])
    case alreadyLoadedLastPage
}
