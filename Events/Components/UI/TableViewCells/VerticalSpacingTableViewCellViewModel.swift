//
//  VerticalSpacingTableViewCellViewModel.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/22/21.
//

import UIKit

// MARK: ViewModel

class VerticalSpacingTableViewCellViewModel: TableViewCellViewModel<VerticalSpacingTableViewCell> {
    let height: CGFloat

    init(height: CGFloat) { self.height = height }

    override func getCell(for tableView: ViewModelCellBasedTableView, at indexPath: IndexPath) -> UITableViewCell? {
        tableView.dequeueReusableCell(forceUnwrap: TableViewCell.self, for: indexPath) { _ in }
    }

    override func getRowHight(for tableView: ViewModelCellBasedTableView, at indexPath: IndexPath) -> CGFloat { height }
}

// MARK: View

class VerticalSpacingTableViewCell: TableViewCell {}
