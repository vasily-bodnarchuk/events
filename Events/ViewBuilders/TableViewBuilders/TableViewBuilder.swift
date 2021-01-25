//
//  TableViewBuilder.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/24/21.
//

import Foundation

protocol TableViewBuilder: class {
    var tableView: ViewModelCellBasedTableView! { get set }
    var viewModels: [TableViewCellViewModelInterface] { get }
}
