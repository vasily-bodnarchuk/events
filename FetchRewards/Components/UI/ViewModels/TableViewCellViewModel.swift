//
//  TableViewCellViewModel.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/21/21.
//

import UIKit

class TableViewCellViewModel<T>: TableViewCellViewModelInterface where T: UITableViewCell & Identifiable {
    
    typealias TableViewCell = T
    
    func getCellClassForRegister(in tableView: ViewModelCellBasedTableView) -> (UITableViewCell & Identifiable).Type {
        T.self
    }
    
    func getRowHight(for tableView: ViewModelCellBasedTableView, at indexPath: IndexPath) -> CGFloat { -1 }

    func getCell(for tableView: ViewModelCellBasedTableView,
                 at indexPath: IndexPath,
                 delegate: TableViewCellDelegateInterface?) -> UITableViewCell? {
        UITableViewCell()
    }
}
