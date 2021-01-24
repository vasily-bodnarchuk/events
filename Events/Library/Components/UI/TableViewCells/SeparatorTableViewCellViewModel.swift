//
//  SeparatorTableViewCellViewModel.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/24/21.
//

import UIKit

// MARK: ViewModel

class SeparatorTableViewCellViewModel: TableViewCellViewModel<SeparatorTableViewCell> {
    private let height: CGFloat
    private let edgeInsets: UIEdgeInsets
    private let color: UIColor

    init(separatorViewColor: UIColor,
         separatorViewHeight: CGFloat,
         separatorViewEdgeInsets: UIEdgeInsets) {
        self.height = separatorViewHeight
        self.edgeInsets = separatorViewEdgeInsets
        self.color = separatorViewColor
    }

    override func getCell(for tableView: ViewModelCellBasedTableView, at indexPath: IndexPath) -> UITableViewCell? {
        tableView.dequeueReusableCell(forceUnwrap: TableViewCell.self, for: indexPath) { [weak self] cell in
            guard let self = self else { return }
            cell.set(separatorViewColor: self.color,
                     separatorViewHeight: self.height,
                     separatorViewEdgeInsets: self.edgeInsets)
        }
    }

    override func getRowHight(for tableView: ViewModelCellBasedTableView, at indexPath: IndexPath) -> CGFloat {
        height + edgeInsets.top + edgeInsets.bottom
    }
}

// MARK: View

class SeparatorTableViewCell: TableViewCell {
    private(set) weak var separatorView: UIView!
    private weak var separatorViewTopAnchor: NSLayoutConstraint!
    private weak var separatorViewLeftAnchor: NSLayoutConstraint!
    private weak var separatorViewRightAnchor: NSLayoutConstraint!
    private weak var separatorViewBottomAnchor: NSLayoutConstraint!
    private weak var separatorViewHeightAnchor: NSLayoutConstraint!

    override func setup() {
        super.setup()
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(separatorView)
        var constaint = separatorView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor)
        constaint.isActive = true
        separatorViewTopAnchor = constaint

        constaint = separatorView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor)
        constaint.isActive = true
        separatorViewLeftAnchor = constaint

        constaint = contentView.safeAreaLayoutGuide.rightAnchor.constraint(equalTo: separatorView.rightAnchor)
        constaint.isActive = true
        separatorViewRightAnchor = constaint

        constaint = contentView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: separatorView.bottomAnchor)
        constaint.isActive = true
        separatorViewBottomAnchor = constaint

        constaint = contentView.heightAnchor.constraint(equalToConstant: 1)
        constaint.priority = .defaultLow
        constaint.isActive = true
        separatorViewHeightAnchor = constaint

        self.separatorView = separatorView
    }

    func set(separatorViewColor: UIColor,
             separatorViewHeight: CGFloat,
             separatorViewEdgeInsets: UIEdgeInsets) {
        separatorView.backgroundColor = separatorViewColor
        separatorViewHeightAnchor.constant = separatorViewHeight
        separatorViewTopAnchor.constant = separatorViewEdgeInsets.top
        separatorViewLeftAnchor.constant = separatorViewEdgeInsets.left
        separatorViewRightAnchor.constant = separatorViewEdgeInsets.right
        separatorViewBottomAnchor.constant = separatorViewEdgeInsets.bottom
    }
}
