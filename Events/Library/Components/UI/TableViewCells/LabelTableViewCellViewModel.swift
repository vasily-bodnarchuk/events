//
//  LabelTableViewCellViewModel.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/24/21.
//

import UIKit

// MARK: ViewModel

class LabelTableViewCellViewModel: TableViewCellViewModel<LabelTableViewCell> {

    private let text: String
    private var configureLabel: ((UILabel) -> Void)
    init(text: String, configureLabel: @escaping ((UILabel) -> Void)) {
        self.text = text
        self.configureLabel = configureLabel
    }

    override func getCell(for tableView: ViewModelCellBasedTableView, at indexPath: IndexPath) -> UITableViewCell? {
        tableView.dequeueReusableCell(forceUnwrap: TableViewCell.self,
                                      for: indexPath) { [weak self] cell in
            guard let self = self else { return }
            cell.set(text: self.text, configureLabel: self.configureLabel)
        }
    }
}

// MARK: View

class LabelTableViewCell: TableViewCell {
    private(set) weak var label: UILabel!
    override func setup() {
        super.setup()
        let label = createLabel(font: .systemFont(ofSize: 17))
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        let leftRightSpacing: CGFloat = 16
        label.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor,
                                    constant: leftRightSpacing).isActive = true
        contentView.safeAreaLayoutGuide.rightAnchor.constraint(equalTo: label.rightAnchor,
                                                               constant: leftRightSpacing).isActive = true
        contentView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        self.label = label
    }

    func set(text: String, configureLabel: ((UILabel) -> Void)) {
        label.text = text
        configureLabel(label)
    }
}

// MARK: ArrangedLabelAddable

extension LabelTableViewCell: ArrangedLabelAddable { }
