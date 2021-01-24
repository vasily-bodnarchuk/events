//
//  MaxWidthImageTableViewCellViewModel.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/23/21.
//

import UIKit
import Nuke

// MARK: ViewModel

class MaxWidthImageTableViewCellViewModel: TableViewCellViewModel<MaxWidthImageTableViewCell> {

    private lazy var cellHeight = { UIScreen.main.bounds.height/3 }()
    private let imageURL: URL
    init(imageURL: URL) { self.imageURL = imageURL }

    override func getCell(for tableView: ViewModelCellBasedTableView, at indexPath: IndexPath) -> UITableViewCell? {
        tableView.dequeueReusableCell(forceUnwrap: TableViewCell.self,
                                      for: indexPath) { [weak self] cell in
            guard let self = self else { return }
            cell.set(imageUrl: self.imageURL)
        }
    }

    override func getRowHight(for tableView: ViewModelCellBasedTableView, at indexPath: IndexPath) -> CGFloat {
        cellHeight
    }
}

// MARK: View

class MaxWidthImageTableViewCell: TableViewCell {
    private weak var eventImageView: UIImageView!
    override func setup() {
        super.setup()
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
        let leftRightSpacing: CGFloat = 16
        imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor,
                                        constant: leftRightSpacing).isActive = true
        contentView.safeAreaLayoutGuide.rightAnchor.constraint(equalTo: imageView.rightAnchor,
                                                               constant: leftRightSpacing).isActive = true
        contentView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        eventImageView = imageView
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        eventImageView.image = nil
    }

    func set(imageUrl: URL) { Nuke.loadImage(with: imageUrl, into: eventImageView) }
}
