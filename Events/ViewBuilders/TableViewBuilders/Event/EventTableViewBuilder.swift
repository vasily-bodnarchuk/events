//
//  EventTableViewBuilder.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/23/21.
//

import Foundation

protocol EventTableViewBuilder: class {
    typealias Delegate = EventHeaderTableViewCellViewModelDelegate
    func getViewModels(completion: @escaping (Result<[TableViewCellViewModelInterface], Error>) -> Void)
}
