//
//  EventListService.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/20/21.
//

import Foundation

protocol EventListService: class {
    func getAll(searchBy keyword: String?, completion: @escaping (Result<[TableViewCellViewModelInterface], Error>) -> Void)
}
