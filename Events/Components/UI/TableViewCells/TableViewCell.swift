//
//  StackViewBasedTableViewCell.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/21/21.
//

import UIKit

class TableViewCell: UITableViewCell, Identifiable {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    func setup() { selectionStyle = .none }
}
