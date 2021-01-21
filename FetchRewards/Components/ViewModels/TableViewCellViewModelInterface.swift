//
//  TableViewCellViewModelInterface.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/20/21.
//

import UIKit

protocol TableViewCellViewModelInterface: ViewModel {
    func getCellClassForRegister(in tableView: ViewModelCellBasedTableView) -> (UITableViewCell & Identifiable).Type
    func getCell(for tableView: ViewModelCellBasedTableView, at indexPath: IndexPath,
                 delegate: TableViewCellDelegateInterface?) -> UITableViewCell?
    func getRowHight(for tableView: ViewModelCellBasedTableView, at indexPath: IndexPath) -> CGFloat
}

extension TableViewCellViewModelInterface {
    func getRowHight(for tableView: ViewModelCellBasedTableView, at indexPath: IndexPath) -> CGFloat { -1 }
}
