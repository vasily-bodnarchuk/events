//
//  TableViewCellViewModel.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/21/21.
//

import UIKit

class TableViewCellViewModel<Cell>: TableViewCellViewModelInterface where Cell: UITableViewCell & Identifiable {

    typealias TableViewCell = Cell

    func getCellClassForRegister(in tableView: ViewModelCellBasedTableView) -> (UITableViewCell & Identifiable).Type {
        Cell.self
    }

    func getRowHight(for tableView: ViewModelCellBasedTableView, at indexPath: IndexPath) -> CGFloat { -1 }

    func getCell(for tableView: ViewModelCellBasedTableView, at indexPath: IndexPath) -> UITableViewCell? {
        UITableViewCell()
    }

    func didSelect(rowAt indexPath: IndexPath, in tableView: ViewModelCellBasedTableView) { }
}
