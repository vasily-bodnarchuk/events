//
//  EventListService.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/20/21.
//

import Foundation

protocol EventListService: class {
    func getAll(completion: @escaping (Result<[TableViewCellViewModelInterface], Error>) -> Void)
}
