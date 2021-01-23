//
//  TableViewCellViewModelInterface.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/20/21.
//

import UIKit

protocol TableViewCellViewModelInterface: ViewModel {
    typealias IdentifiableTableViewCell = UITableViewCell & Identifiable
    func getCellClassForRegister(in tableView: ViewModelCellBasedTableView) -> IdentifiableTableViewCell.Type
    func getCell(for tableView: ViewModelCellBasedTableView, at indexPath: IndexPath) -> UITableViewCell?
    func getRowHight(for tableView: ViewModelCellBasedTableView, at indexPath: IndexPath) -> CGFloat
    func didSelect(rowAt indexPath: IndexPath, in tableView: ViewModelCellBasedTableView)
}

extension TableViewCellViewModelInterface {
    func getRowHight(for tableView: ViewModelCellBasedTableView, at indexPath: IndexPath) -> CGFloat { -1 }
}
